//
//  UserService.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.12.2024.
//

import FirebaseFirestore
import Foundation

final class UserService {
    
    static var shared = UserService()
    
    private init (){}
    
    private let client = FirebaseClient.shared

    func saveUser(user: UserModel, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userId = user.id else {
            completion(.failure(FirebaseError.unknown))
            return
        }

        let request = FirebaseRequest(
            collection: "users",
            documentID: userId,
            data: try? Firestore.Encoder().encode(user)
        )

        client.create(request: request) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getUser(by userId: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        let request = FirebaseRequest(
            collection: "users",
            documentID: userId,
            data: nil
        )

        client.read(request: request, completion: completion)
    }
}
