//
//  RegisterCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import BaseMVVMCKit

final class RegisterCoordinator: BaseCoordinator{
    
    override func start() {
        let registerViewModel = RegisterViewModel()
        let registerVC = RegisterVC(viewModel: registerViewModel)
        registerVC.coordinator = self
      
        push(registerVC)
    }
    
    func showLogin(){}
    
}
