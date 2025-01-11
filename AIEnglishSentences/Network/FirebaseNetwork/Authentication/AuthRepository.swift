//
//  AuthRepository.swift
//  AIEnglishSentences
//
//  Created by mert alp on 11.01.2025.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices
import FirebaseCore

protocol AuthRepository {
    // User Status
    func isUserLoggedIn() -> Bool
    func getCurrentUserId() -> String?
    
    // Email Authentication
    func signUpWithEmail(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func signInWithEmail(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    
    // Google Authentication
    func signInWithGoogle(from viewController: UIViewController, completion: @escaping (Result<User, Error>) -> Void)
    
    // Apple Authentication
    func signInWithApple(presentationAnchor: ASPresentationAnchor, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    
    // Logout
    func logout(completion: @escaping (Result<Void, Error>) -> Void)
    
    // Delete Account
    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void)
}

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
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(AuthError.custom(message: "Missing Firebase Client ID.")))
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { signInResult, error in
            if let error = error {
                completion(.failure(AuthError.map(from: error)))
                return
            }
            
            guard let result = signInResult else {
                completion(.failure(AuthError.custom(message: "Sign-in result is nil.")))
                return
            }
            
            guard let idToken = result.user.idToken?.tokenString else {
                completion(.failure(AuthError.custom(message: "Failed to fetch tokens.")))
                return
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: result.user.accessToken.tokenString
            )
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    completion(.failure(AuthError.map(from: error)))
                } else if let user = authResult?.user {
                    completion(.success(user))
                } else {
                    completion(.failure(AuthError.unknownError))
                }
            }
        }
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
