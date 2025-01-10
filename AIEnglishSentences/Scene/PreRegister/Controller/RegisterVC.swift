//
//  RegisterVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import UIKit
import BaseMVVMCKit
import SnapKit

final class RegisterVC: BaseViewController<RegisterCoordinator, RegisterViewModel>{
    
    private var gender : Gender = .preferNotToSay

    //MARK: - UI Elements
    private var backgroundImageView: UIImageView!
    private var socialButtonsView: SocialButtonsView!
    private var authBar: AuthBar!
    private var subtitleLabel: UILabel!
    private var emailTextField: CustomTextField!
    private var passwordTextField: CustomTextField!
    private var nameTextField: CustomTextField!
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
        authBar = AuthBar(title: "Create Account")
        authBar.delegate = self
        view.addSubview(authBar)
        
        // SubTitle Label
        subtitleLabel = UILabel()
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = UIColor.darkGray
        subtitleLabel.attributedText = NSAttributedString(
            string: "Join us and explore \nthe power of sentences!",
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
        
        // Name TextField
        nameTextField = CustomTextField()
        nameTextField.configure(placeholder: "Enter your Name", type: .normal, title: "Name")
        view.addSubview(nameTextField)
        
        
        // Password TextField
        passwordTextField = CustomTextField()
        passwordTextField.configure(placeholder: "Enter your password", type: .password, title: "Password")
        view.addSubview(passwordTextField)
        
        // Login Button
        loginButton = AuthButton(type: .normal(title: .signup))
        loginButton.delegate = self
        view.addSubview(loginButton)
        
        // SocialButton Container
        let socialButtonsViewModel = SocialButtonsViewModel(
            actionText: "Already have an account? ",
            actionHighlightedText: "Login",
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
            self.coordinator?.showLogin()
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
        
        // Name Text Field
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(UIHelper.dynamicHeight(42))
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-22)
        }
        
        // Email Text Field
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(UIHelper.dynamicHeight(124))
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-22)
        }
        
     
        // Password Text Field
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(UIHelper.dynamicHeight(206))
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-22)
        }
        
        // Login Button
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(socialButtonsView.snp.top).offset(-UIHelper.dynamicHeight(20))
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(UIHelper.dynamicHeight(40))
        }

        // Social Buttons View
        socialButtonsView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-UIHelper.dynamicHeight(10))
            make.leading.trailing.equalToSuperview()
        }
        
    }
}

extension RegisterVC: AuthBarDelegate {
    func didTapBackButton() {
        coordinator?.pop()
    }
}

extension RegisterVC: AuthButtonDelegate {
    func didTapButton(type: AuthButtonType) {
        let isEmailValid = emailTextField.validate(with: "Please enter your email.")
        let isNameValid = nameTextField.validate(with: "Please enter your name.")
        let isPasswordValid = passwordTextField.validate(with: "Please enter your password.")
        
        guard isEmailValid, isPasswordValid, isNameValid else {
            print("Validation failed.")
            return
        }
        viewModel.register(email: emailTextField.text!, name: nameTextField.text!, password: passwordTextField.text!, gender: gender ) { isSucces in
            switch isSucces {
            case true:
                self.coordinator?.showDashboard()
                
            case false:
                print("Register failed.")
        
            }
        }
    }
}
