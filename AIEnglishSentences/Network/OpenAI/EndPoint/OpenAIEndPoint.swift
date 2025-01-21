//
//  OpenAIEndPoint.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.12.2024.
//

import Foundation

enum OpenAIEndpoint: RequestProtocol {
    case generateSentences(parameters: GenerateSentencesParameters, apiKey: String)

    var urlRequest: URLRequest {
        var request = URLRequest(url: URL(string: ApiConstants.baseURL)!)
        request.httpMethod = "POST"

        switch self {
        case .generateSentences(let parameters, let apiKey):
            request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            ApiConstants.defaultHeaders.forEach { key, value in
                request.addValue(value, forHTTPHeaderField: key)
            }
            request.httpBody = parameters.toJSONData()
        }

        return request
    }
}
