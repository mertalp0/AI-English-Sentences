//
//  GenerateSentencesParameters.swift
//  AIEnglishSentences
//
//  Created by mert alp on 20.01.2025.
//

import Foundation

struct GenerateSentencesParameters {
    let inputWords: String
    let maxWords: Int
    let sentenceCount: Int
    let category: String
    let writingTone: String
    let writingStyle: String

    func toJSONData() -> Data? {
        let prompt = """
        Write a single sentence that includes '\(inputWords)' and does not exceed \(maxWords) words.
        Ensure the content aligns with the category '\(category)' and maintains a \(writingTone) tone.
        Additionally, the sentence should reflect a \(writingStyle) style.
        """

        let body: [String: Any] = [
            "model": ApiConstants.defaultModel,
            "messages": [
                ["role": "system", "content": "You are a helpful assistant."],
                ["role": "user", "content": prompt]
            ],
            "max_tokens": maxWords * sentenceCount * 2,
            "n": sentenceCount,
            "temperature": ApiConstants.defaultTemperature
        ]

        return try? JSONSerialization.data(withJSONObject: body)
    }
}
