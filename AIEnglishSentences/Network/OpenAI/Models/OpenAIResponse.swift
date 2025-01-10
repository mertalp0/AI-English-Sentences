//
//  OpenAIResponse.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.12.2024.
//

import Foundation

// MARK: - OpenAI Response Model
struct OpenAIResponse: Codable {
    
    struct Choice: Codable {
        let message: OpenAIMessage
    }
    struct OpenAIMessage: Codable {
        let content: String
    }
    let choices: [Choice]
}
