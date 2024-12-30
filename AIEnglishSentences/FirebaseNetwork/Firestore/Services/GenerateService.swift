//
//  GenerateService.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.12.2024.
//

import FirebaseFirestore
import Foundation

final class GenerateService {
    
    static let shared = GenerateService()
    
    private let client = FirebaseClient.shared
    
    private init() {}

    func saveSentence(sentence: NewSentence, completion: @escaping (Result<String, Error>) -> Void) {
        let request = FirebaseRequest(
            collection: "sentences",
            documentID: sentence.id,
            data: try? Firestore.Encoder().encode(sentence)
        )

        client.create(request: request, completion: completion)
    }

    func getGenerates(for generateIds: [String], completion: @escaping (Result<[NewSentence], Error>) -> Void) {
        let requests = generateIds.map { id in
            FirebaseRequest(collection: "sentences", documentID: id, data: nil)
        }

        let group = DispatchGroup()
        var results = [NewSentence]()
        var errors = [Error]()

        requests.forEach { request in
            group.enter()
            client.read(request: request) { (result: Result<NewSentence, Error>) in
                switch result {
                case .success(let generate):
                    results.append(generate)
                case .failure(let error):
                    errors.append(error)
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            if errors.isEmpty {
                completion(.success(results))
            } else {
                completion(.failure(errors.first!))
            }
        }
    }
}
