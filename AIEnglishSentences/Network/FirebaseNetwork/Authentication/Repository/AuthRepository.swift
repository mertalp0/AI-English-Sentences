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

