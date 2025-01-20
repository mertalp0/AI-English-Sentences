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
    var user: UserModel?

    private init () {}

    private let client = FirebaseClient.shared

    func saveUser(
        user: UserModel,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let request = FirebaseRequest(
            collection: "users",
            documentID: user.id,
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

    func updateUser(
        by userId: String,
        name: String,
        completion: @escaping (Result< Void, Error >) -> Void
    ) {
        let request = FirebaseRequest(
            collection: "users",
            documentID: userId,
            data: ["name": name]
        )

        client.update(request: request) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getUser(
        by userId: String,
        completion: @escaping (Result<UserModel, Error>) -> Void
    ) {
        let request = FirebaseRequest(
            collection: "users",
            documentID: userId,
            data: nil
        )

        client.read(request: request) { [weak self] (result: Result<UserModel, Error>) in
            switch result {
            case .success(let fetchedUser):
                self?.user = fetchedUser
                completion(.success(fetchedUser))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func addGenerateIdToUser(
        userId: String,
        generateId: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let userRef = Firestore.firestore().collection("users").document(userId)

        userRef.updateData([
            "generate": FieldValue.arrayUnion([generateId])
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func removeGenerateIdFromUser(
        userId: String,
        generateId: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let userRef = Firestore.firestore().collection("users").document(userId)

        userRef.updateData([
            "generate": FieldValue.arrayRemove([generateId])
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
