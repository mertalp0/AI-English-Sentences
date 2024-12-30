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

    func generateSentences(inputWords: String, maxWords: Int, sentenceCount: Int, completion: @escaping (Result<[NewSentence], Error>) -> Void) {
        let endpoint = OpenAIEndpoint.generateSentences(inputWords: inputWords, maxWords: maxWords, sentenceCount: sentenceCount, apiKey: apiKey)
        
        provider.request(endpoint, responseType: OpenAIResponse.self) { result in
            switch result {
            case .success(let response):
                // Gelen cevapları NewSentence modeline dönüştürme
                let sentences: [NewSentence] = response.choices.enumerated().map { (index, choice) in
                    NewSentence(
                        id: UUID().uuidString, // Benzersiz ID
                        sentence: choice.message.content.trimmingCharacters(in: .whitespacesAndNewlines),
                        favorite: false, // Varsayılan olarak false
                        category: "General", // Varsayılan bir kategori
                        promt: inputWords,
                        writingTone: "Neutral", // Varsayılan bir ton
                        writingStyle: "Standard", // Varsayılan bir stil
                        createdAt: Date() // Şu anki zaman
                    )
                }
                
                completion(.success(sentences))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
