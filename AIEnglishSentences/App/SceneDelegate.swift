//
//  SceneDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 14.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    let navigationController = UINavigationController()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            let window = UIWindow(windowScene: windowScene)
            appCoordinator = AppCoordinator(navigationController: navigationController)
            appCoordinator?.start()
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
    }
}
