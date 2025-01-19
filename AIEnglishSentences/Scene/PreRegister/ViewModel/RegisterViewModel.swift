//
//  RegisterViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import BaseMVVMCKit
import FirebaseAuth
import AuthenticationServices
import GoogleSignIn

final class RegisterViewModel: BaseViewModel {
    private let authService: AuthService

    init(authService: AuthService = AuthServiceImpl.shared) {
        self.authService = authService
    }

    // MARK: - Register with Email
    func registerWithEmail(
        email: String,
        password: String,
        name: String,
        gender: Gender,
        completion: @escaping (Result<UserModel, AuthError>) -> Void
    ) {
        startLoading()
        authService
            .registerWithEmail(
                email: email,
                password: password,
                name: name,
                gender: gender
            ) { [weak self] result in
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

    // MARK: - Google Registration
    func googleSignIn(
        from viewController: UIViewController,
        completion: @escaping (Result<UserModel, AuthError>) -> Void
    ) {
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

    // MARK: - Apple Registration
    func appleSignIn(
        presentationAnchor: ASPresentationAnchor,
        completion: @escaping (Result<UserModel, AuthError>) -> Void
    ) {
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
