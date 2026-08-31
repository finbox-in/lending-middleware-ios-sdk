//
//  FinBoxWVCoordinator.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import Foundation
import WebKit

/// WebViewCoordinator is a class responsible for coordinating interactions between the WebView and other components.
/**
* It conforms to the WKNavigationDelegate protocol to handle web navigation events.
* It also conforms to the URLSessionDownloadDelegate protocol to handle download tasks initiated by the WebView.
*/
class WebViewCoordinator: NSObject, WKNavigationDelegate, URLSessionDownloadDelegate {
    
    weak var webView: WKWebView?
    var pageLoadTimer: Timer?
    let maxLoadTime: TimeInterval = 0.5
    var initialUrlString: String?
    
    /// WKNavigationDelegate method called when the web view is about to navigate to a new URL.
    /// Allows the coordinator to intercept and handle certain navigation actions, such as downloading content.
    /// - Parameters:
    ///    - webView: The web view that triggered the navigation action.
    ///    - navigationAction: Information about the navigation action, including the URL request.
    ///    - decisionHandler: A closure that must be called to indicate whether the navigation action should be allowed or canceled.
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        // Check if the item should be downloaded
        if navigationAction.shouldPerformDownload {
            // Get the URL
            if let url = navigationAction.request.url {
                DispatchQueue.main.async {
                    self.downloadPDF(String(describing: url), webView: webView)
                }
                decisionHandler(.cancel)
                return
            }
        }
        
        decisionHandler(.allow)
    }
    
    /// Initiates the download process of a PDF file from the specified resource URL using the provided WKWebView.
    /// - Parameters:
    ///    - resourceURL: The URL of the PDF file to download.
    ///    - webView: The WKWebView instance responsible for initiating the download.
    func downloadPDF(_ resourceURL: String, webView: WKWebView) {
        if resourceURL.lowercased().hasPrefix("blob:") {
            // Check if the URL is a blob URL
            // Save the file
            getContentFromBlobURL(blobURL: resourceURL, webView: webView)
        } else {
            // Handle non-blob URLs (e.g., regular http/https URLs)
            guard let url = URL(string: resourceURL) else { return }
            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
            let downloadTask = urlSession.downloadTask(with: url)
            downloadTask.resume()
        }
    }
      
    /// URLSessionDownloadDelegate method called when a download task initiated by the WebView completes.
    /// - Parameters:
    ///    - session: The session containing the download task.
    ///    - downloadTask: The download task that finished downloading.
    ///    - location: The temporary file URL where the downloaded data is stored.
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        guard let url = downloadTask.originalRequest?.url else { return }
        
        // Get the file name
        let fileName = getFileName()
        
        // Get the documents directory URL
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        // Append the custom file name to the documents directory URL
        let destinationURL = documentsDirectory.appendingPathComponent(fileName)
        
        // Delete the original copy if it exists
        try? FileManager.default.removeItem(at: destinationURL)
        
        // Copy from the temporary location to the documents directory with the specified file name
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
        } catch let error {
            debugPrint("Error copying file: \(error.localizedDescription)")
        }
    }
    
    /// Extract contents from blob url
    /// - Parameters:
    ///    - blobURL: Blob url of resource file
    ///    - webView: Instance of webview
    func getContentFromBlobURL(blobURL: String, webView: WKWebView) {
        // Script for getting content from blob url
        let script = """
                        async function createBlobFromUrl(url) {
                          const response = await fetch(url);
                          const blob = await response.blob();
                          return blob;
                        }
                    
                        function blobToDataURLAsync(blob) {
                          return new Promise((resolve, reject) => {
                            const reader = new FileReader();
                            reader.onload = () => {
                              resolve(reader.result);
                            };
                            reader.onerror = reject;
                            reader.readAsDataURL(blob);
                          });
                        }
                    
                        const url = await createBlobFromUrl(blobUrl)
                        return await blobToDataURLAsync(url)
                    """
        
        // Inject JS to the webview
        webView.callAsyncJavaScript(script,
                arguments: ["blobUrl": blobURL],
                in: nil,
                in: WKContentWorld.defaultClient) { result in
            
            switch result {
            case .success(let dataUrl):
                guard let url = URL(string: dataUrl as! String) else {
                    debugPrint("Failed to get data")
                    return
                }
                guard let data = try? Data(contentsOf: url) else {
                    debugPrint("Failed to decode data URL")
                    return
                }
                saveBinaryStringAsPDF(binaryStringData: data.base64EncodedString(), fileName: getFileName())
            case .failure(let error):
                debugPrint("Failed with: \(error)")
            }
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation: WKNavigation!) {
        if isWebUrl(url: webView.url?.absoluteString) {
            startPageLoadTimer()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish: WKNavigation!) {
        cancelPageLoadTimer()
    }
    
    func webView(_ webView: WKWebView, didFail: WKNavigation!) {
        cancelPageLoadTimer()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation: WKNavigation!) {
        cancelPageLoadTimer()
    }
    
    private func startPageLoadTimer() {
        pageLoadTimer?.invalidate()
        pageLoadTimer = Timer.scheduledTimer(withTimeInterval: maxLoadTime, repeats: false) { [weak self] _ in
            self?.handlePageLoadTimeout()
        }
    }
    
    private func cancelPageLoadTimer() {
        pageLoadTimer?.invalidate()
        pageLoadTimer = nil
    }
    
    private func handlePageLoadTimeout() {
        if let webView = self.webView, webView.isLoading {
            webView.stopLoading()
        }
        pageLoadTimer = nil
        let failedUrlString = webView?.url?.absoluteString
                    ?? initialUrlString
                    ?? ""
        
        let html = """
                <!DOCTYPE html>
                <html>
                <head>
                <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
                <style>
                    body {
                        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
                        padding: 40px 20px;
                        text-align: center;
                        background-color: #ffffff;
                        color: #333333;
                    }
                    h1 {
                        font-size: 24px;
                        margin-top: 200px;
                        margin-bottom: 100px;
                    }
                    button {
                        display: block;
                        width: 100%;
                        max-width: 280px;
                        margin: 12px auto;
                        padding: 14px;
                        font-size: 16px;
                        font-weight: 600;
                        border: none;
                        border-radius: 8px;
                        cursor: pointer;
                    }
                    .btn-close {
                        background-color: #f2f2f7;
                        color: #000000;
                    }
                    .btn-retry {
                        background-color: #F47920;
                        color: #ffffff;
                    }
                </style>
                </head>
                <body>
                    <h1>Something went wrong!</h1>
                
                    <button id="retryBtn" class="btn-retry" onclick="retryPageLoad()">Retry</button>
                    <button class="btn-close" onclick="closeWebView()">Close</button>
                
                    <script>
                        const failedUrl = "\(failedUrlString)";
                        let isRetrying = false; 
                        function closeWebView() {
                            window.webkit.messageHandlers.closeWebView.postMessage(null);
                        }
                        function retryPageLoad() {
                            if (isRetrying) return; 
                            isRetrying = true;
                            const retryBtn = document.getElementById('retryBtn');
                            retryBtn.disabled = true;
                            retryBtn.style.opacity = "0.5";
                            retryBtn.innerText = "Retrying...";
                            window.webkit.messageHandlers.retryPageLoad.postMessage(failedUrl);
                        }
                    </script>
                </body>
                </html>
                """
        webView?.loadHTMLString(html, baseURL: nil)
    }
    
    private func isWebUrl(url: String?) -> Bool {
        return url?.starts(with: "http://") == true ||
                url?.starts(with: "https://") == true
    }
    
// Coordinator End
}
