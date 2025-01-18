//
//  AuthService.swift
//  AIEnglishSentences
//
//  Created by mert alp on 11.01.2025.
//

import UIKit
import AuthenticationServices

protocol AuthService {
    // User Status
    func isUserLoggedIn() -> Bool
    func getCurrentUserId() -> String?
    
    // Email Authentication
    func registerWithEmail(
        email: String,
        password: String,
        name: String,
        gender: Gender,
        completion: @escaping (Result<UserModel, AuthError>) -> Void
    )
    
    func loginWithEmail(
        email: String,
        password: String,
        completion: @escaping (Result<UserModel, AuthError>) -> Void
    )
    
    // Google Authentication
    func googleSignIn(
        from viewController: UIViewController,
        completion: @escaping (Result<UserModel, AuthError>) -> Void
    )
    
    // Apple Authentication
    func appleSignIn(
        presentationAnchor: ASPresentationAnchor,
        completion: @escaping (Result<UserModel, AuthError>) -> Void
    )
    
    // Logout
    func logout(completion: @escaping (Result<Void, AuthError>) -> Void)
    
    // Delete Account
    func deleteAccount(completion: @escaping (Result<Void, AuthError>) -> Void)
}
