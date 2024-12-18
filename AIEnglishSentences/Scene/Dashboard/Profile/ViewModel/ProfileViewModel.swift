//
//  ProfileViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import Foundation
import BaseMVVMCKit


final class ProfileViewModel: BaseViewModel {
    
    private let authService = AuthService.shared
    
    func logout(completion: @escaping (Bool) -> Void) {
        startLoading()
        authService.logout { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                switch result {
                case .success:
                    self.stopLoading()
                    completion(true)
                case .failure(let error):
                    self.stopLoading()
                    self.handleError(message: error.localizedDescription)
                    completion(false)
                }
            }
        }
    }
}
