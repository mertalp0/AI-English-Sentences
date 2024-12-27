//
//  DashboardCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import BaseMVVMCKit
import UIKit

final class DashboardCoordinator: BaseCoordinator {

    override func start() {
        // History
        let historyNavigationController = UINavigationController()
        historyNavigationController.navigationBar.isHidden = true
        let historyCoordinator = HistoryCoordinator(navigationController: historyNavigationController)
        historyCoordinator.start()

        // Contexta
        let contextaNavigationController = UINavigationController()
        contextaNavigationController.navigationBar.isHidden = true
        let contextaCoordinator = ContextaCoordinator(navigationController: contextaNavigationController)
        contextaCoordinator.start()
        
        // Profile
        let profileNavigationController = UINavigationController()
        profileNavigationController.navigationBar.isHidden = true
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        profileCoordinator.start()
        
        // Dashboard
        let dashboardController = DashboardController(
            historyCoordinator: historyCoordinator,
            generateSentenceCoordinator: contextaCoordinator,
            profileCoordinator: profileCoordinator
        )

        navigationController?.setViewControllers([dashboardController], animated: true)
    }
}
