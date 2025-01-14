//
//  LoginVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import UIKit
import BaseMVVMCKit
import AuthenticationServices

final class LoginVC: BaseViewController<LoginCoordinator, LoginViewModel> {
    
    //MARK: - UI Elements
    private var backgroundImageView: UIImageView!
    private var socialButtonsView: SocialButtonsView!
    private var authBar: AuthBar!
    private var subtitleLabel: UILabel!
    private var emailTextField: CustomTextField!
    private var passwordTextField: CustomTextField!
    private var loginButton: AuthButton!
    private var forgotPasswordLabel: UILabel!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        setupKeyboardDismissRecognizer()
        
    }
    
    private func setupUI() {
        
        // Background Image
        backgroundImageView = UIImageView()
        backgroundImageView.image = .appImage(.backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        view.addSubview(backgroundImageView)
        
        // AuthBar
        authBar = AuthBar(title: .localized(for: .loginTitle))
        authBar.delegate = self
        view.addSubview(authBar)
        
        // SubTitle Label
        subtitleLabel = UILabel()
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = UIColor.darkGray
        subtitleLabel.attributedText = NSAttributedString(
            string: .localized(for: .loginSubtitle),
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
        
        // Email TextField
        emailTextField = CustomTextField()
        emailTextField.configure(
            placeholder: .localized(for: .emailPlaceholder),
            type: .normal,
            title: .localized(for: .emailTitle)
        )
        view.addSubview(emailTextField)
        
        
        // Password TextField
        passwordTextField = CustomTextField()
        passwordTextField.configure(
            placeholder: .localized(for: .passwordPlaceholder),
            type: .password,
            title: .localized(for: .passwordTitle)
        )
        
        view.addSubview(passwordTextField)
        
        // Login Button
        loginButton = AuthButton(type: .normal(title: .login))
        loginButton.delegate = self
        view.addSubview(loginButton)
        
        // Forgot Password Label
        forgotPasswordLabel = UILabel()
        forgotPasswordLabel.text = .localized(for: .forgotPassword)
        forgotPasswordLabel.font = .dynamicFont(size: 14, weight: .regular)
        forgotPasswordLabel.textAlignment = .center
        forgotPasswordLabel.textColor = .mainColor
        view.addSubview(forgotPasswordLabel)
        
        // SocialButton Container
        let socialButtonsViewModel = SocialButtonsViewModel(
            actionText: .localized(for: .dontHaveAccount),            actionHighlightedText:  .localized(for: .signup),
            googleButtonTitle: .localized(for: .googleButtonTitle),
            appleButtonTitle: .localized(for: .appleButtonTitle)
        )
        
        socialButtonsViewModel.onGoogleButtonTapped = {
            
            self.viewModel.loginWithGoogle(from: self) { [weak self] result in
                switch result {
                case .success(_):
                    self?.coordinator?.showDashboard()
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        
        socialButtonsViewModel.onAppleButtonTapped = {
            
            guard let window = self.view.window else {
                return
            }
            
            self.viewModel.loginWithApple(presentationAnchor: window) { [weak self] result in
                switch result {
                case .success(_):
                    self?.coordinator?.showDashboard()
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        
        socialButtonsViewModel.onActionLabelTapped = {
            self.coordinator?.showRegister()
        }
        
        socialButtonsView = SocialButtonsView(viewModel: socialButtonsViewModel)
        view.addSubview(socialButtonsView)
        
        
    }
    
    private func setupConstraints(){
        
        // Background ImageView
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // AuthBar
        authBar.snp.makeConstraints { make in
            make.top.equalTo(UIHelper.statusBarHeight + UIHelper.dynamicHeight(10))
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIHelper.dynamicHeight(60))
            
        }
        // Subtitle Label
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(authBar.snp.bottom).offset(UIHelper.dynamicHeight(22))
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        // Email Text Field
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(UIHelper.dynamicHeight(48))
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        // Password Text Field
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(UIHelper.dynamicHeight(130))
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        // Login Button
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(socialButtonsView.snp.top).offset(-UIHelper.dynamicHeight(20))
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(UIHelper.dynamicHeight(40))
        }
        
        forgotPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(UIHelper.dynamicHeight(5))
            make.trailing.equalTo(passwordTextField.snp.trailing)
        }
        
        // Social Buttons View
        socialButtonsView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-UIHelper.dynamicHeight(10))
            make.leading.trailing.equalToSuperview()
        }
        
    }
}

extension LoginVC: AuthBarDelegate {
    func didTapBackButton() {
        coordinator?.pop()
    }
}

extension LoginVC: AuthButtonDelegate {
    func didTapButton(type: AuthButtonType) {
        let isEmailValid = emailTextField.validate(with: .localized(for: .validationEmail))
        let isPasswordValid = passwordTextField.validate(with: .localized(for: .validationPassword))
        
        guard isEmailValid, isPasswordValid else {
            print("Validation failed.")
            return
        }
        
        viewModel.loginWithEmail(email: emailTextField.text!, password: passwordTextField.text!) { result in
            switch result {
            case .success(_):
                self.coordinator?.showDashboard()
            case .failure(_):
                print("Error")
            }
        }
        
    }
}
