//
//  LoginViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 11.01.2025.
//

import Foundation
import UIKit
import AuthenticationServices
import BaseMVVMCKit

final class LoginViewModel: BaseViewModel {
    private let authService: AuthService = AuthServiceImpl.shared

    // MARK: - Login with Email
    func loginWithEmail(email: String, password: String, completion: @escaping (Result<UserModel, AuthError>) -> Void) {
        startLoading()
        authService.loginWithEmail(email: email, password: password) { [weak self] result in
            self?.stopLoading()
            switch result {
            case .success(let userModel):
                completion(.success(userModel))
            case .failure(let error):
                self?.handleError(message: error.errorDescription ?? "An error occurred")
                completion(.failure(error))
            }
        }
    }

    // MARK: - Login with Google
    func loginWithGoogle(from viewController: UIViewController, completion: @escaping (Result<UserModel, AuthError>) -> Void) {
        startLoading()
        authService.googleSignIn(from: viewController) { [weak self] result in
            self?.stopLoading()
            switch result {
            case .success(let userModel):
                completion(.success(userModel))
            case .failure(let error):
                self?.handleError(message: error.errorDescription ?? "An error occurred")
                completion(.failure(error))
            }
        }
    }

    // MARK: - Login with Apple
    func loginWithApple(presentationAnchor: ASPresentationAnchor, completion: @escaping (Result<UserModel, AuthError>) -> Void) {
        startLoading()
        authService.appleSignIn(presentationAnchor: presentationAnchor) { [weak self] result in
            self?.stopLoading()
            switch result {
            case .success(let userModel):
                completion(.success(userModel))
            case .failure(let error):
                self?.handleError(message: error.errorDescription ?? "An error occurred")
                completion(.failure(error))
            }
        }
    }
}
