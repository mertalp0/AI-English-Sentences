//
//  RegisterVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import UIKit
import BaseMVVMCKit
import SnapKit

final class RegisterViewController: BaseViewController<RegisterCoordinator, RegisterViewModel> {

    var gender: Gender = .preferNotToSay

    // MARK: - UI Elements
    private var backgroundImageView: UIImageView!
    var socialButtonsView: SocialButtonsView!
    var authBar: AuthBar!
    private var subtitleLabel: UILabel!
    var emailTextField: CustomTextField!
    var passwordTextField: CustomTextField!
    var nameTextField: CustomTextField!
    var loginButton: AuthButton!

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboardDismissRecognizer()
    }
}

// MARK: - UI Setup
private extension RegisterViewController {

    private func setupUI() {
        setupBackgroundImageView()
        setupAuthBar()
        setupSubtitleLabel()
        setupNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupSocialButtonsView()
        setupConstraints()
    }

    private func setupBackgroundImageView() {
        backgroundImageView = UIImageView()
        backgroundImageView.image = .appImage(.backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        view.addSubview(backgroundImageView)
    }

    private func setupAuthBar() {
        authBar = AuthBar(title: .localized(for: .createAccountTitle))
        authBar.delegate = self
        view.addSubview(authBar)
    }

    private func setupSubtitleLabel() {
        subtitleLabel = UILabel()
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = UIColor.darkGray
        subtitleLabel.attributedText = NSAttributedString(
            string: .localized(for: .registerSubtitle),
            attributes: [
                .font: UIFont.dynamicFont(size: 22, weight: .bold),
                .foregroundColor: UIColor.darkGray,
                .kern: 1.0,
                .paragraphStyle: {
                    let style = NSMutableParagraphStyle()
                    style.lineSpacing = 5
                    style.alignment = .center
                    return style
                }()
            ]
        )
        view.addSubview(subtitleLabel)
    }

    private func setupNameTextField() {
        nameTextField = CustomTextField()
        nameTextField.configure(
            placeholder: .localized(for: .namePlaceholder),
            type: .normal,
            title: .localized(for: .nameTitle)
        )
        view.addSubview(nameTextField)
    }

    private func setupEmailTextField() {
        emailTextField = CustomTextField()
        emailTextField.configure(
            placeholder: .localized(for: .emailPlaceholder),
            type: .normal,
            title: .localized(for: .emailTitle)
        )
        view.addSubview(emailTextField)
    }

    private func setupPasswordTextField() {
        passwordTextField = CustomTextField()
        passwordTextField.configure(
            placeholder: .localized(for: .passwordPlaceholder),
            type: .password,
            title: .localized(for: .passwordTitle)
        )
        view.addSubview(passwordTextField)
    }

    private func setupLoginButton() {
        loginButton = AuthButton(type: .normal(title: .signup))
        loginButton.delegate = self
        view.addSubview(loginButton)
    }

    private func setupSocialButtonsView() {
        socialButtonsView = SocialButtonsView(
            googleButtonTitle: .localized(for: .googleButtonTitle),
            appleButtonTitle: .localized(for: .appleButtonTitle),
            actionText: .localized(for: .alreadyHaveAccount),
            actionHighlightedText: .localized(for: .login)
        )
        socialButtonsView.delegate = self
        view.addSubview(socialButtonsView)
    }

    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        authBar.snp.makeConstraints { make in
            make.top.equalTo(UIHelper.statusBarHeight + UIHelper.dynamicHeight(10))
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIHelper.dynamicHeight(60))
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(authBar.snp.bottom).offset(UIHelper.dynamicHeight(22))
            make.leading.trailing.equalToSuperview().inset(32)
        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(UIHelper.dynamicHeight(42))
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-22)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(UIHelper.dynamicHeight(124))
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-22)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(UIHelper.dynamicHeight(206))
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-22)
        }

        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(socialButtonsView.snp.top).offset(-UIHelper.dynamicHeight(20))
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(UIHelper.dynamicHeight(40))
        }

        socialButtonsView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-UIHelper.dynamicHeight(10))
            make.leading.trailing.equalToSuperview()
        }
    }
}
