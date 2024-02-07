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
        
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        
        // Delete the original copy
        try? FileManager.default.removeItem(at: destinationURL)
        
        // Copy from temp to Document
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
        } catch let error {
            debugPrint("fileDownload: error \(error.localizedDescription)")
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
    
// Coordinator End
}
