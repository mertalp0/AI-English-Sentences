//
//  PrivacyPolicyCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 4.01.2025.
//

import BaseMVVMCKit

final class PrivacyPolicyCoordinator: BaseCoordinator {

    override func start() {
        let privacyPolicyViewModel = PrivacyPolicyViewModel()
        let privacyPolicyVC = PrivacyPolicyViewController(viewModel: privacyPolicyViewModel)
        privacyPolicyVC.coordinator = self
        push(privacyPolicyVC)
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
