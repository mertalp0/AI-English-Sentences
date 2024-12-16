//
//  InfoCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import BaseMVVMCKit

final class InfoCoordinator: BaseCoordinator {
    
    override func start() {
        let infoViewModel = InfoViewModel()
        let infoVC = InfoVC(viewModel: infoViewModel)
        infoVC.coordinator = self
        push(infoVC)
    }
    
    func showLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: self.navigationController!)
        addChildCoordinator(loginCoordinator)
        loginCoordinator.start()
    }
    
    func showRegister() {
        let registerCoordinator = RegisterCoordinator(navigationController: self.navigationController!)
        addChildCoordinator(registerCoordinator)
        registerCoordinator.start()
    }
   
}
