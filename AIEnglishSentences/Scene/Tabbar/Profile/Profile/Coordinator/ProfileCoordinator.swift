//
//  ProfileCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import BaseMVVMCKit
import UIKit

final class ProfileCoordinator: BaseCoordinator {

    override func start() {
        let profileViewModel = ProfileViewModel()
        let profileVC = ProfileViewController(viewModel: profileViewModel)
        profileVC.coordinator = self
        push(profileVC)
    }

    func showInfo() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate,
           let appCoordinator = sceneDelegate.appCoordinator {
            appCoordinator.start()
        }
    }

    func shareApp() {
        let appStoreLink = AppConstants.URLs.appUrl
        let activityVC = UIActivityViewController(activityItems: [appStoreLink], applicationActivities: nil)
        self.navigationController?.present(activityVC, animated: true, completion: nil)
    }

    func showApps() {
        guard let navigationController = navigationController else {
            fatalError("Navigation controller is nil in showResult")
        }

        let myAppsCoordinator = MyAppsCoordinator(navigationController: navigationController)
        myAppsCoordinator.start()

        if let tabBarController = navigationController.tabBarController {
            tabBarController.setTabBar(hidden: true, animated: false)
        }
    }

    func showLanguagePage() {
        guard let navigationController = navigationController else {
            fatalError("Navigation controller is nil in showResult")
        }

        let coordinator = LanguageSelectionCoordinator(navigationController: navigationController)
        coordinator.start()

        if let tabBarController = navigationController.tabBarController {
            tabBarController.setTabBar(hidden: true, animated: false)
        }
    }

    func showPrivacyPolicy() {
        guard let navigationController = navigationController else {
            fatalError("Navigation controller is nil in showResult")
        }

        let coordinator = PrivacyPolicyCoordinator(navigationController: navigationController)
        coordinator.start()

        if let tabBarController = navigationController.tabBarController {
            tabBarController.setTabBar(hidden: true, animated: false)
        }
    }
}
