//
//  FirebaseClient.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.12.2024.
//


import FirebaseFirestore

final class FirebaseClient {
    static let shared = FirebaseClient()
    private let db = Firestore.firestore()
    private init() {}

    // MARK: - Veri Ekleme
    func create(request: FirebaseRequest, completion: @escaping (Result<String, Error>) -> Void) {
        guard let data = request.data, let documentID = request.documentID else {
            completion(.failure(FirebaseError.unknown))
            return
        }

        let documentRef = db.collection(request.collection).document(documentID)
        
        // Check if the document already exists
        documentRef.getDocument { (documentSnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let documentSnapshot = documentSnapshot, documentSnapshot.exists {
                // Document already exists, return an error
                completion(.failure(FirebaseError.documentAlreadyExists))
            } else {
                // Document does not exist, proceed to create it
                documentRef.setData(data) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(documentID))
                    }
                }
            }
        }
    }

    // MARK: - Veri Okuma
    func read<T: Decodable>(request: FirebaseRequest, completion: @escaping (Result<T, Error>) -> Void) {
        guard let documentID = request.documentID else {
            completion(.failure(FirebaseError.missingDocument))
            return
        }

        let document = db.collection(request.collection).document(documentID)
        document.getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = snapshot?.data() else {
                completion(.failure(FirebaseError.missingDocument))
                return
            }

            do {
                let decodedData = try Firestore.Decoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(FirebaseError.decodingFailed))
            }
        }
    }

    // MARK: - Veri Güncelleme
    func update(request: FirebaseRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let documentID = request.documentID, let data = request.data else {
            completion(.failure(FirebaseError.unknown))
            return
        }

        let document = db.collection(request.collection).document(documentID)
        document.updateData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    // MARK: - Veri Silme
    func delete(request: FirebaseRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let documentID = request.documentID else {
            completion(.failure(FirebaseError.missingDocument))
            return
        }

        let document = db.collection(request.collection).document(documentID)
        document.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
