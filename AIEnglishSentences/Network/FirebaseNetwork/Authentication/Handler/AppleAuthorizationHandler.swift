//
//  AppleAuthorizationHandler.swift
//  AIEnglishSentences
//
//  Created by mert alp on 24.12.2024.
//

import FirebaseAuth
import UIKit
import GoogleSignIn
import FirebaseCore
import AuthenticationServices

final class AppleAuthorizationHandler: NSObject {
    static let shared = AppleAuthorizationHandler()

    private var completionHandler: ((Result<AuthDataResult, Error>) -> Void)?
    private var presentationAnchor: ASPresentationAnchor?

    private override init() {}

    func signInWithApple(
        presentationAnchor: ASPresentationAnchor,
        completion: @escaping (Result<AuthDataResult, Error>) -> Void
    ) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self

        controller.performRequests()
        self.completionHandler = completion
        self.presentationAnchor = presentationAnchor
    }
}

// MARK: - ASAuthorizationControllerDelegate
extension AppleAuthorizationHandler: ASAuthorizationControllerDelegate {
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        handleAppleIDCredential(from: authorization)
    }

    private func handleAppleIDCredential(from authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            Logger.log("Invalid credential type.", type: .error)
            return
        }

        guard let identityToken = appleIDCredential.identityToken,
              let idTokenString = String(data: identityToken, encoding: .utf8) else {
            handleAuthorizationError("Failed to retrieve identity token.", code: -1, description: "Invalid identity token")
            return
        }

        signInWithFirebase(idTokenString: idTokenString)
    }

    private func signInWithFirebase(idTokenString: String) {
        let credential = OAuthProvider.credential(
            providerID: .apple,
            idToken: idTokenString,
            rawNonce: "",
            accessToken: nil
        )

        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            if let error = error {
                Logger.log("Firebase Sign-In Error: \(error.localizedDescription)", type: .error)
                self?.completionHandler?(.failure(error))
                return
            }

            if let authResult = authResult {
                Logger.log("Firebase Sign-In Success!", type: .info)
                self?.completionHandler?(.success(authResult))
            }
        }
    }

    private func handleAuthorizationError(_ message: String, code: Int, description: String) {
        Logger.log(message, type: .error)
        self.completionHandler?(
            .failure(
                NSError(
                    domain: "AppleAuthorizationHandler",
                    code: code,
                    userInfo: [NSLocalizedDescriptionKey: description]
                )
            )
        )
    }

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        Logger.log("Apple Sign-In Failed: \(error.localizedDescription)", type: .error)
        self.completionHandler?(.failure(error))
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension AppleAuthorizationHandler: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.presentationAnchor!
    }
}
