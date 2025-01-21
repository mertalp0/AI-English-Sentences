//
//  AuthServiceImpl.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.01.2025.
//

import Foundation
import UIKit
import AuthenticationServices

final class AuthServiceImpl: AuthService {
    static let shared = AuthServiceImpl()

    private init() {}

    private let authRepository: AuthRepository = FirebaseAuthRepositoryImpl()

    func isUserLoggedIn() -> Bool {
        return authRepository.isUserLoggedIn()
    }

    func getCurrentUserId() -> String? {
        return authRepository.getCurrentUserId()
    }

    func registerWithEmail(
        email: String,
        password: String,
        name: String,
        gender: Gender,
        completion: @escaping (Result<UserModel, AuthError>) -> Void
    ) {
        authRepository.signUpWithEmail(email: email, password: password) { result in
            switch result {
            case .success(let user):
                self.saveUserToFirestoreForSocial(
                    userId: user.uid,
                    name: name,
                    email: user.email ?? "No Email",
                    gender: .preferNotToSay, type: .social
                ) { success in
                    if success {
                        let userModel = UserModel(
                            id: user.uid,
                            name: user.displayName ?? "Google User",
                            email: user.email ?? "No Email",
                            gender: Gender.preferNotToSay.rawValue,
                            createdAt: Date(),
                            generate: []
                        )

                        self.loginSubscribe(userId: user.uid) { isSucces in
                            if isSucces {
                                completion(.success(userModel))
                            } else {
                                completion(.failure(AuthError.unknownError))
                            }
                        }
                    } else {
                        completion(.failure(AuthError.unknownError))
                    }
                }
            case .failure(let error):
                completion(.failure(AuthError.map(from: error)))
            }
        }
    }

    func loginWithEmail(
        email: String,
        password: String,
        completion: @escaping (Result<UserModel, AuthError>) -> Void
    ) {
        authRepository.signInWithEmail(email: email, password: password) { result in
            switch result {
            case .success(let user):
                let userModel = UserModel(
                    id: user.uid,
                    name: user.displayName ?? "Unknown",
                    email: user.email ?? email,
                    gender: "Unknown",
                    createdAt: Date(),
                    generate: []
                )

                self.loginSubscribe(userId: user.uid) { isSucces in
                    if isSucces {
                        completion(.success(userModel))
                    } else {
                        completion(.failure(AuthError.unknownError))
                    }
                }
            case .failure(let error):
                completion(.failure(AuthError.map(from: error)))
            }
        }
    }

    func googleSignIn(
        from viewController: UIViewController,
        completion: @escaping (Result<UserModel, AuthError>) -> Void
    ) {
        authRepository.signInWithGoogle(from: viewController) { result in
            switch result {
            case .success(let user):
                self.saveUserToFirestoreForSocial(
                    userId: user.uid,
                    name: user.displayName ?? "Google User",
                    email: user.email ?? "No Email",
                    gender: .preferNotToSay, type: .social
                ) { success in
                    if success {
                        let userModel = UserModel(
                            id: user.uid,
                            name: user.displayName ?? "Google User",
                            email: user.email ?? "No Email",
                            gender: Gender.preferNotToSay.rawValue,
                            createdAt: Date(),
                            generate: []
                        )

                        self.loginSubscribe(userId: user.uid) { isSucces in
                            if isSucces {
                                completion(.success(userModel))
                            } else {
                                completion(.failure(.unknownError))
                            }
                        }
                    } else {
                        completion(.failure(AuthError.unknownError))
                    }
                }
            case .failure(let error):
                completion(.failure(AuthError.map(from: error)))
            }
        }
    }

    func appleSignIn(
        presentationAnchor: ASPresentationAnchor,
        completion: @escaping (Result<UserModel, AuthError>) -> Void
    ) {
        authRepository.signInWithApple(presentationAnchor: presentationAnchor) { result in
            switch result {
            case .success(let credentials):
                self.saveUserToFirestoreForSocial(
                    userId: credentials.user.uid,
                    name: credentials.user.displayName ?? "Apple User",
                    email: credentials.user.email ?? "No Email",
                    gender: .preferNotToSay, type: .social
                ) { success in
                    if success {
                        let userModel = UserModel(
                            id: credentials.user.uid,
                            name: credentials.user.displayName ?? "Apple User",
                            email: credentials.user.email ?? "No Email",
                            gender: Gender.preferNotToSay.rawValue,
                            createdAt: Date(),
                            generate: []
                        )

                        self.loginSubscribe(userId: credentials.user.uid) { isSucces in
                            if isSucces {
                                completion(.success(userModel))
                            } else {
                                completion(.failure(.unknownError))
                            }
                        }
                    } else {
                        completion(.failure(AuthError.unknownError))
                    }
                }
            case .failure(let error):
                completion(.failure(AuthError.map(from: error)))
            }
        }
    }

    func logout(completion: @escaping (Result<Void, AuthError>) -> Void) {
        authRepository.logout { result in
            switch result {
            case .success:
                self.logoutSubscribe { isSuccess in
                    if isSuccess {
                        completion(.success(()))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
            case .failure(let error):
                completion(.failure(AuthError.map(from: error)))
            }
        }
    }

    func deleteAccount(completion: @escaping (Result<Void, AuthError>) -> Void) {
        authRepository.deleteAccount { result in
            switch result {
            case .success:
                self.logoutSubscribe { isSuccess in
                    if isSuccess {
                        completion(.success(()))
                    } else {
                        completion(.failure(.unknownError))
                    }
                }
            case .failure(let error):
                completion(.failure(AuthError.map(from: error)))
            }
        }
    }
}

// MARK: - Helper func saveUserToFirestore
extension AuthServiceImpl {
    enum AuthType {
        case social
        case email
    }

    private func saveUserToFirestoreForSocial(
        userId: String,
        name: String,
        email: String,
        gender: Gender,
        type: AuthType,
        completion: @escaping (Bool) -> Void
    ) {
        let userModel = UserModel(
            id: userId,
            name: name,
            email: email,
            gender: gender.rawValue,
            createdAt: Date(),
            generate: []
        )

        UserService.shared.saveUser(user: userModel) { result in
             switch result {
             case .success:
                 completion(true)
             case .failure(let error):
                 if let firebaseError = error as? FirebaseError, firebaseError == .documentAlreadyExists || type == .social {
                     completion(true)
                 } else {
                     completion(false)
                 }
             }
         }
    }
}

// MARK: - Helper SubscriptionService
extension AuthServiceImpl {

    private func loginSubscribe(
        userId: String,
        completion: @escaping (Bool) -> Void
    ) {
        SubscriptionService.shared.login(userId: userId) { isSuccess in
            if isSuccess {
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    private func logoutSubscribe(completion: @escaping (Bool) -> Void) {
        SubscriptionService.shared.logout { isSuccess in
            if isSuccess {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
