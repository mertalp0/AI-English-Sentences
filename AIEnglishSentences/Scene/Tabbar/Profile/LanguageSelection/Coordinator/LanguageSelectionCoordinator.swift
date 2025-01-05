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
        let LanguageSelectionVC = LanguageSelectionVC(viewModel: languageSelectionViewModel)
        LanguageSelectionVC.coordinator = self
        push(LanguageSelectionVC)
    }
    
    func back() {
        guard let navigationController = navigationController else {
            fatalError("Navigation controller is nil in ResultCoordinator")
        }

        if let tabBarController = navigationController.tabBarController {
            tabBarController.setTabBar(hidden: false, animated: true)
        }

        pop()
    }
}
