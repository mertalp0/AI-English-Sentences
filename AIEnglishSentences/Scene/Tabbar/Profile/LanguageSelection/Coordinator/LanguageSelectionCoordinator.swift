//
//  LanguageSelectionCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 4.01.2025.
//

import BaseMVVMCKit

final class LanguageSelectionCoordinator: BaseCoordinator {

    override func start() {
        let languageSelectionViewModel = LanguageSelectionViewModel()
        let languageSelectionVC = LanguageSelectionViewController(viewModel: languageSelectionViewModel)
        languageSelectionVC.coordinator = self
        push(languageSelectionVC)
    }

    func back() {
        guard let navigationController = navigationController else {
            Logger.log("NavigationController is nil.", type: .error)
            return
        }

        if let tabBarController = navigationController.tabBarController {
            tabBarController.setTabBar(hidden: false, animated: true)
        }
        pop()
    }
}
