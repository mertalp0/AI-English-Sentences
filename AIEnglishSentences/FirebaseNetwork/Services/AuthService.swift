//
//  AuthService.swift
//  AIEnglishSentences
//
//  Created by mert alp on 18.12.2024.
//

import FirebaseAuth
import UIKit
import GoogleSignIn
import FirebaseCore
import AuthenticationServices

final class AuthService {
    static let shared = AuthService()
    private init() {}
    
    // MARK: - Is User Logged In?
    func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    // MARK: - Get Current User ID
    func getCurrentUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    // MARK: - Sign Up with Email
    func signUpWithEmail(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let user = result?.user {
                completion(.success(user))
            }
        }
    }
    
    // MARK: - Sign In with Email
    func signInWithEmail(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let user = result?.user {
                completion(.success(user))
            }
        }
    }
    
    func signInWithGoogle(with viewController: UIViewController, completion: @escaping (Result<User, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(NSError(domain: "FirebaseError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Missing Firebase Client ID"])))
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(
            withPresenting: viewController
        ) { signInResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let result = signInResult else {
                completion(.failure(NSError(domain: "SignInError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Sign-in result is nil"])))
                return
            }
            
            let user = result.user
            let accessToken = user.accessToken.tokenString
    
            guard let idToken = user.idToken?.tokenString else {
                completion(.failure(NSError(domain: "TokenError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch tokens"])))
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                } else if let user = authResult?.user {
                    completion(.success(user))
                } else {
                    completion(.failure(NSError(domain: "SignInError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unexpected error during sign-in"])))
                }
            }
        }
    }
    
    func signInWithApple(
            presentationAnchor: ASPresentationAnchor,
            completion: @escaping (Result<AuthDataResult, Error>) -> Void
        ) {
            AppleAuthorizationHandler.shared.signInWithApple(
                presentationAnchor: presentationAnchor,
                completion: completion
            )
        }
    
    // MARK: - Log Out
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}


final class AppleAuthorizationHandler: NSObject {
    static let shared = AppleAuthorizationHandler() // Singleton
    
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
        
        // Kullanıcıya Apple giriş ekranını göster
        controller.performRequests()
        
        // Completion handler'ı saklıyoruz
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
            
            // Firebase Credential oluştur
            let credential = OAuthProvider.credential(
                withProviderID: "apple.com",
                idToken: idTokenString,
                rawNonce: ""
            )
            
            // Firebase ile giriş yap
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
