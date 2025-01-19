//
//  PrivacyPolicyViewController+AppBarDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

import Foundation

extension PrivacyPolicyViewController: AppBarDelegate {
    func leftButtonTapped() {
        coordinator?.back()
    }

    func rightButtonTapped() {}
}
