//
//  OpenAIEndPoint.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.12.2024.
//

import Foundation

enum OpenAIEndpoint: RequestProtocol {
    case generateSentences(inputWords: String, maxWords: Int, sentenceCount: Int, category: String, writingTone: String, writingStyle: String, apiKey: String)
    
    var urlRequest: URLRequest {
        let baseURL = "https://api.openai.com/v1/chat/completions"
        var request = URLRequest(url: URL(string: baseURL)!)
        request.httpMethod = "POST"
        
        switch self {
        case .generateSentences(let inputWords, let maxWords, let sentenceCount, let category, let writingTone, let writingStyle, let apiKey):
            
            // Prompt oluşturma
            let prompt = """
            Write a single sentence that includes '\(inputWords)' and does not exceed \(maxWords) words. 
            Ensure the content aligns with the category '\(category)' and maintains a \(writingTone) tone. 
            Additionally, the sentence should reflect a \(writingStyle) style.
            """
            
            let body: [String: Any] = [
                "model": "gpt-3.5-turbo",
                "messages": [
                    ["role": "system", "content": "You are a helpful assistant."],
                    ["role": "user", "content": prompt]
                ],
                "max_tokens": maxWords * sentenceCount * 2,
                "n": sentenceCount,
                "temperature": 0.7
            ]
            
            request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        return request
    }
}
