//
//  GoogleSignInHandler.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.01.2025.
//

import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import UIKit

final class GoogleSignInHandler {

    static let shared = GoogleSignInHandler()
    private init() {}

    func signInWithGoogle(
        from viewController: UIViewController,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(AuthError.custom(message: .localized(for: .errorMissingFirebaseClientId))))
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
                completion(.failure(AuthError.custom(message: .localized(for: .errorSignInResultNil))))
                return
            }
            guard let idToken = result.user.idToken?.tokenString else {
                completion(.failure(AuthError.custom(message: .localized(for: .errorFailedToFetchTokens))))
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
}
