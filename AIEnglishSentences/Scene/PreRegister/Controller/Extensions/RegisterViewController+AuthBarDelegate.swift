//
//  AuthBarDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

extension RegisterViewController: AuthBarDelegate {
    func didTapBackButton() {
        coordinator?.pop()
    }
}
