//
//  GenerateService.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.12.2024.
//

import FirebaseFirestore
import Foundation

final class GenerateService {
    private let client = FirebaseClient.shared

    func saveGenerate(generate: GenerateModel, completion: @escaping (Result<String, Error>) -> Void) {
        let request = FirebaseRequest(
            collection: "generate",
            documentID: nil,
            data: try? Firestore.Encoder().encode(generate)
        )

        client.create(request: request, completion: completion)
    }

    func getGenerates(for generateIds: [String], completion: @escaping (Result<[GenerateModel], Error>) -> Void) {
        let requests = generateIds.map { id in
            FirebaseRequest(collection: "generate", documentID: id, data: nil)
        }

        let group = DispatchGroup()
        var results = [GenerateModel]()
        var errors = [Error]()

        requests.forEach { request in
            group.enter()
            client.read(request: request) { (result: Result<GenerateModel, Error>) in
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
