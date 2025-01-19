//
//  AuthButtonDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

extension RegisterViewController: AuthButtonDelegate {
    func didTapButton(type: AuthButtonType) {
        let isEmailValid = emailTextField.validate(with: .localized(for: .validationEmail))
        let isNameValid = nameTextField.validate(with: .localized(for: .validationName))
        let isPasswordValid = passwordTextField.validate(with: .localized(for: .validationPassword))

        guard isEmailValid, isPasswordValid, isNameValid else {
            return
        }

        viewModel
            .registerWithEmail(
                email: emailTextField.text!,
                password: passwordTextField.text!,
                name: nameTextField.text! ,
                gender: gender
            ) {  result in
            switch result {
            case .success:
                self.coordinator?.showDashboard()
            case .failure:
                break
            }
        }
    }
}
