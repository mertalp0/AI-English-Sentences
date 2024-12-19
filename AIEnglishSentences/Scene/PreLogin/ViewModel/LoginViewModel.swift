//
//  LoginViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import BaseMVVMCKit

final class LoginViewModel: BaseViewModel {
    private let authService = AuthService.shared
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void){
        
        startLoading()
        authService.signInWithEmail(email: email, password: password) { result in
            switch result {
            case .success(let user):
                self.stopLoading()
                print("Giriş başarılı: \(user.email ?? "")")
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
