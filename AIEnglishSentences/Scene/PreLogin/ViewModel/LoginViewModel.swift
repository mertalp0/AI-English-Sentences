//
//  LoginViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import BaseMVVMCKit
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

final class LoginViewModel: BaseViewModel {
    private let authService = AuthService.shared
    private let userService = UserService.shared
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        startLoading()
        authService.signInWithEmail(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.stopLoading()
                print("Giriş başarılı: \(user.email ?? "")")
                completion(true)
            case .failure(let error):
                self?.stopLoading()
                self?.handleError(message: error.localizedDescription)
                print("Kayıt hatası: \(error.localizedDescription)")
                completion(false)
            }
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
                print("Firestore kaydı tamamlandı: \(email)")
                completion(true)
            case .failure(let error):
#warning("must be error enum type ")
                if error.localizedDescription == "The document already exists in the database."{
                    completion(true)
                }else {
                    self.handleError(message: error.localizedDescription)
                    print("Firestore kaydı hatası: \(error.localizedDescription)")
                    completion(false)
                }
                
            }
        }
    }
}
