//
//  ApiConstants.swift
//  AIEnglishSentences
//
//  Created by mert alp on 20.01.2025.
//

import Foundation

struct ApiConstants {
    static let baseURL = "https://api.openai.com/v1/chat/completions"
    static let defaultHeaders: [String: String] = [
        "Content-Type": "application/json"
    ]
    static let defaultModel = "gpt-3.5-turbo"
    static let defaultTemperature: Double = 0.7
}
