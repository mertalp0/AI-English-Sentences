//
//  LoginViewController+SocialButtonsViewDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 20.01.2025.
//

extension LoginViewController: SocialButtonsViewDelegate {
    func didTapGoogleButton() {
        self.viewModel.loginWithGoogle(from: self) { [weak self] result in
            switch result {
            case .success:
                self?.coordinator?.showDashboard()
            case .failure:
                break
            }
        }
    }

    func didTapAppleButton() {
        guard let window = self.view.window else {
            return
        }
        self.viewModel.loginWithApple(presentationAnchor: window) { [weak self] result in
            switch result {
            case .success:
                self?.coordinator?.showDashboard()
            case .failure:
                break
            }
        }
    }

    func didTapActionLabel() {
        self.coordinator?.showRegister()
    }
}
