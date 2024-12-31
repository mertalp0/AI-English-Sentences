//
//  DashboardController.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import UIKit

final class DashboardController: UITabBarController {

    private let historyCoordinator: HistoryCoordinator
    private let generateSentenceCoordinator: ContextaCoordinator
    private let profileCoordinator: ProfileCoordinator

    // MARK: - Initialization
    init(historyCoordinator: HistoryCoordinator, generateSentenceCoordinator: ContextaCoordinator, profileCoordinator: ProfileCoordinator) {
        self.historyCoordinator = historyCoordinator
        self.generateSentenceCoordinator = generateSentenceCoordinator
        self.profileCoordinator = profileCoordinator
        super.init(nibName: nil, bundle: nil)
        setupTabBar()
        self.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTabBar() {
        let historyNavigationController = historyCoordinator.navigationController!
        historyNavigationController.tabBarItem = UITabBarItem(
            title: "History",
            image: UIImage(systemName: "clock"),
            tag: 0
        )
        historyNavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        historyNavigationController.navigationBar.shadowImage = UIImage()
        historyNavigationController.navigationBar.isTranslucent = true

        let generateSentenceNavigationController = generateSentenceCoordinator.navigationController!
        generateSentenceNavigationController.tabBarItem = UITabBarItem(
            title: "Generate",
            image: UIImage(systemName: "text.badge.plus"),
            tag: 1
        )
        generateSentenceNavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        generateSentenceNavigationController.navigationBar.shadowImage = UIImage()
        generateSentenceNavigationController.navigationBar.isTranslucent = true

        let profileNavigationController = profileCoordinator.navigationController!
        profileNavigationController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.crop.circle"),
            tag: 2
        )
        profileNavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        profileNavigationController.navigationBar.shadowImage = UIImage()
        profileNavigationController.navigationBar.isTranslucent = true

        viewControllers = [
            historyNavigationController,
            generateSentenceNavigationController,
            profileNavigationController
        ]
    }
}

extension DashboardController: UITabBarControllerDelegate {
    // MARK: - UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let currentVC = selectedViewController else { return true }

        if let fromView = currentVC.view, let toView = viewController.view, fromView != toView {
            UIView.transition(
                from: fromView,
                to: toView,
                duration: 0.3,
                options: [.transitionCrossDissolve],
                completion: nil
            )
        }

        return true
    }
}
