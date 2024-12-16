//
//  DashboardController.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import UIKit

final class DashboardController: UITabBarController {
    
    private let historyCoordinator: HistoryCoordinator
    private let generateSentenceCoordinator: GenerateSentenceCoordinator
    private let profileCoordinator: ProfileCoordinator
    
    // MARK: - Initialization
    init(historyCoordinator: HistoryCoordinator, generateSentenceCoordinator: GenerateSentenceCoordinator, profileCoordinator: ProfileCoordinator) {
        self.historyCoordinator = historyCoordinator
        self.generateSentenceCoordinator = generateSentenceCoordinator
        self.profileCoordinator = profileCoordinator
        super.init(nibName: nil, bundle: nil)
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup TabBar
    private func setupTabBar() {
        
        let historyNavigationController = historyCoordinator.navigationController!
        historyNavigationController.tabBarItem = UITabBarItem(
            title: "History",
            image: UIImage(systemName: "clock"),
            tag: 0
        )
        
        let generateSentenceNavigationController = generateSentenceCoordinator.navigationController!
        generateSentenceNavigationController.tabBarItem = UITabBarItem(
            title: "Generate",
            image: UIImage(systemName: "text.badge.plus"),
            tag: 1
        )
        
        let profileNavigationController = profileCoordinator.navigationController!
        profileNavigationController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.crop.circle"),
            tag: 1
        )
        
        
        viewControllers = [
            historyNavigationController,
            generateSentenceNavigationController,
            profileNavigationController
        ]
    }
}
