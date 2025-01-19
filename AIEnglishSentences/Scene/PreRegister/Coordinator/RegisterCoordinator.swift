//
//  RegisterCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import BaseMVVMCKit
import UIKit

final class RegisterCoordinator: BaseCoordinator {

    private let source: NavigationSource

    init(navigationController: UINavigationController, from source: NavigationSource) {
        self.source = source
        super.init(navigationController: navigationController)
    }

    override func start() {
        let registerViewModel = RegisterViewModel()
        let registerVC = RegisterViewController(viewModel: registerViewModel)
        registerVC.coordinator = self
        push(registerVC)
    }

    func showLogin() {
        switch source {
        case .info:
            let loginCoordinator = LoginCoordinator(navigationController: self.navigationController!, from: .register)
            loginCoordinator.start()
        case.login:
            pop()
        default:
            break
        }
    }

    func showDashboard() {
        guard let navigationController = self.navigationController else {
            Logger.log("NavigationController is nil. Unable to show dashboard.", type: .error)
            return
        }
        let dashboardCoordinator = DashboardCoordinator(navigationController: navigationController)
        dashboardCoordinator.start()
    }
}
