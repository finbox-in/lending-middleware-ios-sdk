//
//  APIService.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import Foundation

struct APIService {
    func makePostRequest(urlString: String) {

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        // TODO: Replace with params
        let parameters: [String: Any] = [
            "key1": "value1",
            "key2": "value2"
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    return
                }

                if (200...299).contains(httpResponse.statusCode) {
                    if let data = data {
                        // Handle the response data here
                        print("Response: \(String(data: data, encoding: .utf8) ?? "")")
                    }
                } else {
                    print("HTTP Response Code: \(httpResponse.statusCode)")
                }
            }

            task.resume()
        } catch {
            print("Error serializing JSON: \(error.localizedDescription)")
        }
    }
}
