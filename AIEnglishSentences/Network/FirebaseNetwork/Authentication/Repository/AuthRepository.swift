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
    func isUserLoggedIn() -> Bool
    func getCurrentUserId() -> String?

    func signUpWithEmail(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)

    func signInWithEmail(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)

    func signInWithGoogle(from viewController: UIViewController, completion: @escaping (Result<User, Error>) -> Void)

    func signInWithApple(presentationAnchor: ASPresentationAnchor, completion: @escaping (Result<AuthDataResult, Error>) -> Void)

    func logout(completion: @escaping (Result<Void, Error>) -> Void)

    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void)
}
