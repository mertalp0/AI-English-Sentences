//
//  InfoViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import BaseMVVMCKit
import Foundation
import AuthenticationServices

final class InfoViewModel: BaseViewModel {
    private let authService: AuthService = AuthServiceImpl.shared

    // MARK: - Login with Google
    func loginWithGoogle(from viewController: UIViewController, completion: @escaping (Result<UserModel, AuthError>) -> Void) {
        startLoading()
        authService.googleSignIn(from: viewController) { [weak self] result in
            self?.stopLoading()
            switch result {
            case .success(let userModel):
                completion(.success(userModel))
            case .failure(let error):
                self?.handleError(message: error.errorDescription ?? .localized(for: .sharedErrorMessage))
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
                self?.handleError(message: error.errorDescription ?? .localized(for: .sharedErrorMessage))
                completion(.failure(error))
            }
        }
    }
}
