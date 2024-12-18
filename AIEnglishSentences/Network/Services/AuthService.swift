//
//  AuthService.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.12.2024.
//

import FirebaseAuth
import UIKit

final class AuthService {
    static let shared = AuthService()
    private init() {}
    
    // MARK: - Kullanıcı Giriş Yapmış mı?
    func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    // MARK: - Kullanıcı ID'si Al
    func getCurrentUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    // MARK: - E-Posta ile Kayıt Ol
    func signUpWithEmail(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let user = result?.user {
                completion(.success(user))
            }
        }
    }
    
    // MARK: - E-Posta ile Giriş Yap
    func signInWithEmail(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let user = result?.user {
                completion(.success(user))
            }
        }
    }
    
    // MARK: - Çıkış Yap
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
