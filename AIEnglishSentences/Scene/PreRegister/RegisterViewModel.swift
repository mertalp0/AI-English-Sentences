//
//  RegisterViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import UIKit
import BaseMVVMCKit
import FirebaseAuth

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
