//
//  ApiClient.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.12.2024.
//

import Foundation

final class APIClient {
    static let shared = APIClient()

    func sendRequest<T: Decodable>(
        _ endpoint: RequestProtocol,
        responseType: T.Type,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        guard endpoint.urlRequest.url != nil else {
            completion(.failure(.invalidURL))
            return
        }

        let request = endpoint.urlRequest
        NetworkLogger.log(request: request)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if error != nil {
                completion(.failure(.requestFailed))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }.resume()
    }
}
