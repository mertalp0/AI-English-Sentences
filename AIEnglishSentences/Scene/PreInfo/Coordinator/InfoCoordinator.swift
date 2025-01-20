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
        guard let navigationController = self.navigationController else {
            Logger.log("NavigationController is nil.", type: .error)
            return
        }
        let loginCoordinator = LoginCoordinator(navigationController: navigationController, from: .info)
        loginCoordinator.start()
    }

    func showRegister() {
        guard let navigationController = self.navigationController else {
            Logger.log("NavigationController is nil.", type: .error)
            return
        }
        let registerCoordinator = RegisterCoordinator(navigationController: navigationController, from: .info)
        registerCoordinator.start()
    }

    func showDashboard() {
        guard let navigationController = self.navigationController else {
            Logger.log("NavigationController is nil.", type: .error)
            return
        }
        let dashboardCoordinator = DashboardCoordinator(navigationController: navigationController)
        dashboardCoordinator.start()
    }
}

enum NavigationSource {
    case info
    case register
    case login
}
