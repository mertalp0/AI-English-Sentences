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
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        view.addSubview(backgroundImageView)
        
        // AuthBar
        authBar = AuthBar(title: "Login here")
        authBar.delegate = self
        view.addSubview(authBar)
        
        // SubTitle Label
        subtitleLabel = UILabel()
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = UIColor.darkGray
        subtitleLabel.attributedText = NSAttributedString(
            string: "Welcome back you’ve \nbeen missed!",
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
        emailTextField.configure(placeholder: "Enter your email", type: .normal, title: "Email address")
        view.addSubview(emailTextField)
        
        
        // Password TextField
        passwordTextField = CustomTextField()
        passwordTextField.configure(placeholder: "Enter your password", type: .password, title: "Password")
        view.addSubview(passwordTextField)
        
        // Login Button
        loginButton = AuthButton(type: .normal(title: .login))
        loginButton.delegate = self
        view.addSubview(loginButton)
        
        // Forgot Password Label
        forgotPasswordLabel = UILabel()
        forgotPasswordLabel.text = "Forgot Password?"
        forgotPasswordLabel.font = .dynamicFont(size: 14, weight: .regular)
        forgotPasswordLabel.textAlignment = .center
        forgotPasswordLabel.textColor = .mainColor
        view.addSubview(forgotPasswordLabel)
        
        // SocialButton Container
        let socialButtonsViewModel = SocialButtonsViewModel(
            actionText: "You don’t have an account?",
            actionHighlightedText: "Sign up",
            googleButtonTitle: "Continue with Google",
            appleButtonTitle: "Continue with Apple"
        )
        
        socialButtonsViewModel.onGoogleButtonTapped = {
            self.viewModel.googleSignIn(from: self) {  [weak self] isSuccess in
                if isSuccess {
                    self?.coordinator?.showDashboard()
                }
            }
        }
        
        socialButtonsViewModel.onAppleButtonTapped = {
            self.viewModel.signInWithApple(presentationAnchor: self.view.window!) { [weak self] isSuccess in
                if isSuccess {
                    self?.coordinator?.showDashboard()
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
        let isEmailValid = emailTextField.validate(with: "Please enter your email.")
        let isPasswordValid = passwordTextField.validate(with: "Please enter your password.")
        
        guard isEmailValid, isPasswordValid else {
            print("Validation failed.")
            return
        }
        
        viewModel.login(email: emailTextField.text!, password: passwordTextField.text!) { isSuccess in
            if isSuccess {
                self.coordinator?.showDashboard()
            }
        }
    }
}
