//
//  AppCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import BaseMVVMCKit

final class AppCoordinator: BaseCoordinator{
    
    private let authService = AuthService.shared
    
    override func start() {
        navigationController?.navigationBar.isHidden = true
        
        if authService.isUserLoggedIn() {
            let dashboardCoordinator = DashboardCoordinator(navigationController: self.navigationController!)
            dashboardCoordinator.start()
            
        }else {
            let infoCoordinator = InfoCoordinator(navigationController: self.navigationController!)
            infoCoordinator.start()
        }
    }
    
}
