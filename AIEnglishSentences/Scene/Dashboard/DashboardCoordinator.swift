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
        let historyNavigationController = UINavigationController()
        let historyCoordinator = HistoryCoordinator(navigationController: historyNavigationController)
        historyCoordinator.start()

        let generateSentenceNavigationController = UINavigationController()
        let generateSentenceCoordinator = ContextaCoordinator(navigationController: generateSentenceNavigationController)
        generateSentenceCoordinator.start()
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        profileCoordinator.start()
        
        let dashboardController = DashboardController(
            historyCoordinator: historyCoordinator,
            generateSentenceCoordinator: generateSentenceCoordinator,
            profileCoordinator: profileCoordinator
        )

        navigationController?.setViewControllers([dashboardController], animated: true)
    }
}
