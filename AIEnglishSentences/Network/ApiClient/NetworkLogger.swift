//
//  NetworkLogger.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.12.2024.
//

import Foundation

class NetworkLogger {
    static func log(request: URLRequest) {
        print("\n--- HTTP Request ---")
        print("URL: \(request.url?.absoluteString ?? "No URL")")
        print("Method: \(request.httpMethod ?? "No Method")")
        if let headers = request.allHTTPHeaderFields {
            print("Headers: \(headers)")
        }
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("Body: \(bodyString)")
        }
        print("---------------------\n")
    }
}
