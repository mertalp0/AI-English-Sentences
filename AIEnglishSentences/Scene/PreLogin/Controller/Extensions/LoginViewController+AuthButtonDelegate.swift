//
//  AuthButtonDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

extension LoginViewController: AuthButtonDelegate {
    func didTapButton(type: AuthButtonType) {
        let isEmailValid = emailTextField.validate(with: .localized(for: .validationEmail))
        let isPasswordValid = passwordTextField.validate(with: .localized(for: .validationPassword))

        guard isEmailValid, isPasswordValid else {
            return
        }

        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }

        viewModel.loginWithEmail(email: email, password: password) { result in
            switch result {
            case .success:
                self.coordinator?.showDashboard()
            case .failure:
                break
            }
        }
    }
}
