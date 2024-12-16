//
//  LoginCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import BaseMVVMCKit

final class LoginCoordinator: BaseCoordinator {
    
    override func start() {
     
        let loginViewModel = LoginViewModel()
        let loginVC = LoginVC(viewModel: loginViewModel)
        loginVC.coordinator = self
        push(loginVC)
        
    }
}
