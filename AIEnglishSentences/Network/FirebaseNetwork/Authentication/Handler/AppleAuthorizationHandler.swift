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
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let identityToken = appleIDCredential.identityToken,
                  let idTokenString = String(data: identityToken, encoding: .utf8) else {
                Logger.log("Failed to retrieve identity token.", type: .error)
                self.completionHandler?(
                    .failure(
                        NSError(
                            domain: "AppleAuthorizationHandler",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey: "Invalid identity token"]
                        )
                    )
                )
                return
            }

            let credential = OAuthProvider.credential(
                providerID: .apple,
                idToken: idTokenString,
                rawNonce: "",
                accessToken: nil
            )

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    Logger.log("Firebase Sign-In Error: \(error.localizedDescription)", type: .error)
                    self.completionHandler?(.failure(error))
                } else if let authResult = authResult {
                    Logger.log("Firebase Sign-In Success!", type: .info)
                    self.completionHandler?(.success(authResult))
                }
            }
        }
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
