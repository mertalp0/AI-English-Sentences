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
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground

        // Selected item appearance
        appearance.stackedLayoutAppearance.selected.iconColor = .mainColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.mainColor ?? UIColor.systemBlue]

        // Unselected item appearance
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.lightGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]

        self.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = appearance
        }

        let historyNavigationController = historyCoordinator.navigationController!
        historyNavigationController.tabBarItem = UITabBarItem(
            title: .localized(for: .tabBarHistory),
            image: .appIcon(.clock),
            tag: 0
        )
        historyNavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        historyNavigationController.navigationBar.shadowImage = UIImage()
        historyNavigationController.navigationBar.isTranslucent = true

        let generateSentenceNavigationController = generateSentenceCoordinator.navigationController!
        generateSentenceNavigationController.tabBarItem = UITabBarItem(
            title: .localized(for: .tabBarGenerate),
            image: .appIcon(.textBadgePlus),
            tag: 1
        )
        generateSentenceNavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        generateSentenceNavigationController.navigationBar.shadowImage = UIImage()
        generateSentenceNavigationController.navigationBar.isTranslucent = true

        let profileNavigationController = profileCoordinator.navigationController!
        profileNavigationController.tabBarItem = UITabBarItem(
            title: .localized(for: .tabBarProfile),
            image: .appIcon(.personCropCircle),
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
