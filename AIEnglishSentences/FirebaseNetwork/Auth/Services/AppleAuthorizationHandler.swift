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
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let identityToken = appleIDCredential.identityToken,
                  let idTokenString = String(data: identityToken, encoding: .utf8) else {
                print("Failed to retrieve identity token.")
                self.completionHandler?(.failure(NSError(domain: "AppleAuthorizationHandler", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid identity token"])))
                return
            }
            
            let credential = OAuthProvider.credential(
                withProviderID: "apple.com",
                idToken: idTokenString,
                rawNonce: ""
            )
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Sign-In Error: \(error.localizedDescription)")
                    self.completionHandler?(.failure(error))
                } else if let authResult = authResult {
                    print("Firebase Sign-In Success!")
                    self.completionHandler?(.success(authResult))
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Sign-In Failed: \(error.localizedDescription)")
        self.completionHandler?(.failure(error))
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension AppleAuthorizationHandler: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.presentationAnchor!
    }
}
