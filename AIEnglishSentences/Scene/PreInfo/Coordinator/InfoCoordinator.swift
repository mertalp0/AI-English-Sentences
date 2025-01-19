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
        let infoVC = InfoViewController(viewModel: infoViewModel)
        infoVC.coordinator = self
        push(infoVC)
    }

    func showLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: self.navigationController!, from: .info)
        loginCoordinator.start()
    }

    func showRegister() {
        let registerCoordinator = RegisterCoordinator(navigationController: self.navigationController!, from: .info)
        registerCoordinator.start()
    }

    func showDashboard() {
        let dashboardCoordinator = DashboardCoordinator(navigationController: self.navigationController!)
        dashboardCoordinator.start()
    }
}

enum NavigationSource {
    case info
    case register
    case login
}
