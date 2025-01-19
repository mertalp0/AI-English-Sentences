//
//  AuthService.swift
//  AIEnglishSentences
//
//  Created by mert alp on 11.01.2025.
//

import UIKit
import AuthenticationServices

protocol AuthService {

    func isUserLoggedIn() -> Bool
    func getCurrentUserId() -> String?

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

    func googleSignIn(
        from viewController: UIViewController,
        completion: @escaping (Result<UserModel, AuthError>) -> Void
    )

    func appleSignIn(
        presentationAnchor: ASPresentationAnchor,
        completion: @escaping (Result<UserModel, AuthError>) -> Void
    )

    func logout(completion: @escaping (Result<Void, AuthError>) -> Void)

    func deleteAccount(completion: @escaping (Result<Void, AuthError>) -> Void)
}
