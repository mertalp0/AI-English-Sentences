//
//  FirebaseAuthRepositoryImpl.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.01.2025.
//

import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import AuthenticationServices

final class FirebaseAuthRepositoryImpl: AuthRepository {
    
    // MARK: - User Status
    func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func getCurrentUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    // MARK: - Email Authentication
    func signUpWithEmail(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(AuthError.map(from: error)))
                return
            }
            if let user = authResult?.user {
                completion(.success(user))
            } else {
                completion(.failure(AuthError.unknownError))
            }
        }
    }
    
    func signInWithEmail(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(AuthError.map(from: error)))
                return
            }
            if let user = authResult?.user {
                completion(.success(user))
            } else {
                completion(.failure(AuthError.unknownError))
            }
        }
    }
    
    
    // MARK: - Google Authentication
    func signInWithGoogle(from viewController: UIViewController, completion: @escaping (Result<User, Error>) -> Void) {
        GoogleSignInHandler.shared.signInWithGoogle(from: viewController, completion: completion)
    }
    
    // MARK: - Apple Authentication
    func signInWithApple(presentationAnchor: ASPresentationAnchor, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        AppleAuthorizationHandler.shared.signInWithApple(
            presentationAnchor: presentationAnchor,
            completion: completion )
    }
    
    // MARK: - Logout
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    // MARK: - Delete Account
    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(AuthError.userNotLoggedIn))
            return
        }
        
        user.delete { error in
            if let error = error {
                completion(.failure(AuthError.map(from: error)))
            } else {
                completion(.success(()))
            }
        }
    }
}
