//
//  AuthButtonDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

extension InfoViewController: AuthButtonDelegate {
    func didTapButton(type: AuthButtonType) {
        switch type {
        case .normal:
            coordinator?.showLogin()
        case .google:
            break
        case .apple:
            break
        }
    }
}
