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
        navigationController?.present(privacyPolicyVC, animated: true)
    }
}
