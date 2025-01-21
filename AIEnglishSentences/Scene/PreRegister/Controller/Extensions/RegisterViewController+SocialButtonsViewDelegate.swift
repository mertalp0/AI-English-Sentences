//
//  RegisterViewController+SocialButtonsViewDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 20.01.2025.
//

extension RegisterViewController: SocialButtonsViewDelegate {
    func didTapGoogleButton() {
        self.viewModel.googleSignIn(from: self) { [weak self] result in
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

        self.viewModel.appleSignIn(presentationAnchor: window) { [weak self] result in
            switch result {
            case .success:
                self?.coordinator?.showDashboard()
            case .failure:
                break
            }
        }
    }

    func didTapActionLabel() {
        self.coordinator?.showLogin()
    }
}
