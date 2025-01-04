//
//  RegisterViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import UIKit
import BaseMVVMCKit
import FirebaseAuth
import AuthenticationServices
import GoogleSignIn

enum Gender: String{
    case male = "Male"
    case female = "Female"
    case preferNotToSay = "PreferNottoSay"
}

final class RegisterViewModel: BaseViewModel {
    private let authService = AuthService.shared
    private let userService = UserService.shared
    
    func register(email: String, name: String, password: String, gender: Gender, completion: @escaping (Bool) -> Void) {
        startLoading()
        
        createUser(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.saveUserToFirestore(
                    userId: user.uid,
                    name: name,
                    email: email,
                    gender: gender
                ) { success in
                    self.stopLoading()
                    completion(success)
                }
                
            case .failure(let error):
                self.stopLoading()
                self.handleError(message: error.localizedDescription)
                print("Registration failed: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    private func createUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        authService.signUpWithEmail(email: email, password: password) { result in
            completion(result)
        }
    }
    
    func googleSignIn(from viewController: UIViewController, completion: @escaping (Bool) -> Void) {
        startLoading()
        authService.signInWithGoogle(with: viewController) { [weak self] result in
            switch result {
            case .success(let user):
                self?.saveUserToFirestore(
                    userId: user.uid,
                    name: user.displayName ?? "Unknown",
                    email: user.email ?? "No Email",
                    gender: .preferNotToSay
                ) { success in
                    self?.stopLoading()
                    if success {
                        print("Firestore kaydı başarılı: \(user.email ?? "")")
                        completion(true)
                    } else {
                        print("Firestore kaydı başarısız: \(user.email ?? "")")
                        completion(false)
                    }
                }
            case .failure(let error):
                self?.stopLoading()
                if let signInError = error as? GIDSignInError, signInError.code == .canceled {
                    
                    print("Google Sign-In canceled by user.")
                    completion(false)
                } else {
                    self?.handleError(message: error.localizedDescription)
                    print("Google Sign-In Error: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
    }
    
    func signInWithApple(presentationAnchor: ASPresentationAnchor, completion: @escaping (Bool) -> Void) {
            startLoading()
           authService.signInWithApple(presentationAnchor: presentationAnchor) { [weak self] result in
               switch result {
               case .success(let authResult):
                   let userId = authResult.user.uid
                   let email = authResult.user.email ?? "No Email"
                   let name = authResult.user.displayName ?? "Apple User"
                   
                   self?.saveUserToFirestore(userId: userId, name: name, email: email, gender: .preferNotToSay) { success in
                       self?.stopLoading()
                       if success {
                           print("Firestore kaydı başarılı: \(userId)")
                           completion(true)
                       } else {
                           print("Firestore kaydı başarısız: \(userId)")
                           completion(false)
                       }
                       
                }
                   
               case .failure(let error):
                   self?.stopLoading()
                   self?.handleError(message: error.localizedDescription)
                   print("Apple Sign-In Failed: \(error.localizedDescription)")
                   completion(false)
               }
           }
       }
    
    private func saveUserToFirestore(userId: String, name: String, email: String, gender: Gender, completion: @escaping (Bool) -> Void) {
        let userModel = UserModel(
            id: userId,
            name: name,
            email: email,
            gender: gender.rawValue,
            createdAt: Date(),
            generate: []
        )
        
        userService.saveUser(user: userModel) { result in
            switch result {
            case .success():
                print("User successfully saved to Firestore: \(email)")
                completion(true)
            case .failure(let error):
                self.handleError(message: error.localizedDescription)
                print("Failed to save user to Firestore: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}

