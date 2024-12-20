//
//  RegisterViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import UIKit
import BaseMVVMCKit

enum Gender: String{
    case male = "Male"
    case female = "Female"
    case preferNotToSay = "Prefer Not to Say"
}

final class RegisterViewModel: BaseViewModel {
    private let authService = AuthService.shared
    
    func register(email: String, name: String, password: String, gender:Gender ,completion: @escaping (Bool) -> Void) {
        
        startLoading()
        authService.signUpWithEmail(email: email, password: password) { result in
            switch result {
            case .success(let user):
                self.stopLoading()
                print("Kullanıcı kaydedildi: \(user.email ?? "")")
                completion(true)
            case .failure(let error):
                self.stopLoading()
                self.handleError(message: error.localizedDescription)
                print("Kayıt hatası: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}
