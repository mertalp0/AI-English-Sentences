//
//  RegisterViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import UIKit
import BaseMVVMCKit

final class RegisterViewModel: BaseViewModel {
    private let authService = AuthService.shared
    
    func register(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
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
