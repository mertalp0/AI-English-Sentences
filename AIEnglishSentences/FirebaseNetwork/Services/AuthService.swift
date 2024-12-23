//
//  AuthService.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.12.2024.
//

import FirebaseAuth
import UIKit
import GoogleSignIn
import FirebaseCore

final class AuthService {
    static let shared = AuthService()
    private init() {}
    
    // MARK: - Is User Logged In?
    func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    // MARK: - Get Current User ID
    func getCurrentUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    // MARK: - Sign Up with Email
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
    
    // MARK: - Sign In with Email
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
    
    func signInWithGoogle(with viewController: UIViewController, completion: @escaping (Result<User, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(NSError(domain: "FirebaseError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Missing Firebase Client ID"])))
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(
            withPresenting: viewController
        ) { signInResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let result = signInResult else {
                completion(.failure(NSError(domain: "SignInError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Sign-in result is nil"])))
                return
            }
            
            let user = result.user
            let accessToken = user.accessToken.tokenString
    
            guard let idToken = user.idToken?.tokenString else {
                completion(.failure(NSError(domain: "TokenError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch tokens"])))
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                } else if let user = authResult?.user {
                    completion(.success(user))
                } else {
                    completion(.failure(NSError(domain: "SignInError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unexpected error during sign-in"])))
                }
            }
        }
    }
    
    func signInWithApple(){}
    
    // MARK: - Log Out
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
