//
//  OpenAIEndPoint.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.12.2024.
//

import Foundation

enum OpenAIEndpoint: RequestProtocol {
    
    case generateSentences(inputWords: String, maxWords: Int, sentenceCount: Int, apiKey: String)
    
    var urlRequest: URLRequest {
        let baseURL = "https://api.openai.com/v1/chat/completions"
        var request = URLRequest(url: URL(string: baseURL)!)
        request.httpMethod = "POST"
        
        switch self {
        case .generateSentences(let inputWords, let maxWords, let sentenceCount, let apiKey):
            let body: [String: Any] = [
                "model": "gpt-3.5-turbo",
                "messages": [
                    ["role": "system", "content": "You are a helpful assistant."],
                    ["role": "user", "content": "Write \(sentenceCount) sentences containing \(inputWords) under \(maxWords) words."]
                ],
                "max_tokens": maxWords * 2,
                "n": sentenceCount
            ]
            request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        return request
    }
}
