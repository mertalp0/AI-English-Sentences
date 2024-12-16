//
//  LoginCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import BaseMVVMCKit
import UIKit

final class LoginCoordinator: BaseCoordinator {
    
    private let source: NavigationSource
    
    init(navigationController: UINavigationController, from source: NavigationSource) {
        self.source = source
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        
        let loginViewModel = LoginViewModel()
        let loginVC = LoginVC(viewModel: loginViewModel)
        loginVC.coordinator = self
        push(loginVC)
        
    }
    
    func showRegister(){
        switch source{
        case .info:
            let registerCoordinator = RegisterCoordinator(navigationController: self.navigationController!, from: .login)
            registerCoordinator.start()
        case.register:
            pop()
        default:
            print("error")
        }
    }
    
    func showDashboard(){
        let dashboardCoordinator = DashboardCoordinator(navigationController: self.navigationController!)
        dashboardCoordinator.start()
    }
}

