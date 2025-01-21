//
//  URLSessionProvider.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.12.2024.
//

import Foundation

class URLSessionProvider {
    static let shared = URLSessionProvider()
    private init() {}

    func request<T: Decodable>(_ endpoint: RequestProtocol,
                               responseType: T.Type,
                               completion: @escaping (Result<T, APIError>) -> Void) {
        APIClient.shared.sendRequest(endpoint, responseType: responseType, completion: completion)
    }
}
