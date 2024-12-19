//
//  OpenAIService.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.12.2024.
//


import Foundation

final class OpenAIService {
    private let provider = URLSessionProvider.shared
    private let apiKey: String

    init() {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "OPENAI_API_KEY") as? String else {
            fatalError("API Key is missing.")
        }
        self.apiKey = key
    }

    func generateSentences(inputWords: String, maxWords: Int, sentenceCount: Int, completion: @escaping (Result<[String], Error>) -> Void) {
        let endpoint = OpenAIEndpoint.generateSentences(inputWords: inputWords, maxWords: maxWords, sentenceCount: sentenceCount, apiKey: apiKey)
        
        provider.request(endpoint, responseType: OpenAIResponse.self) { result in
            switch result {
            case .success(let response):
                let sentences = response.choices.map { $0.message.content.trimmingCharacters(in: .whitespacesAndNewlines) }
                completion(.success(sentences))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
