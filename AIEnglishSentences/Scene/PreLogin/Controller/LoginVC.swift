//
//  LoginVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import UIKit
import BaseMVVMCKit

final class LoginVC: BaseViewController<LoginCoordinator, LoginViewModel>{
    
    
    //MARK: - UI Elements
    private var pageTitle : UILabel!
    private var loginButton : CustomButton!
    private var registerButton : CustomButton!
    private var backButton : CustomButton!
    private var emailTextField : CustomTextField!
    private var passwordTextField : CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupActions()
        setupKeyboardDismissRecognizer() 
    }
    
    private func setupUI(){
        
        //Page Title
        pageTitle = UILabel()
        pageTitle.text = String(describing: type(of: self))
        pageTitle.textColor = .black
        
        view.addSubview(pageTitle)
        pageTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        setupTextFields()
        setupButtons()
        
        }
        
    private func setupTextFields(){
        // Email TextField
        emailTextField = CustomTextField()
        emailTextField.configure(placeholder: "Enter your email",type: .normal)
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(140)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        // Password TextField
        passwordTextField = CustomTextField()
        passwordTextField.configure(placeholder: "Enter your password",type: .password)
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func setupButtons(){
    //Login button
    loginButton = CustomButton()
    loginButton.configure(title: "Login", backgroundColor: .systemGreen, textColor: .white)
    
    view.addSubview(loginButton)
    loginButton.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.bottom.equalToSuperview().offset(-50)
    }
    
    //Register button
    registerButton = CustomButton()
    registerButton.configure(title: "Register", backgroundColor: .systemGreen, textColor: .white)
    
    view.addSubview(registerButton)
    registerButton.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.bottom.equalToSuperview().offset(-120)
    }
    
    //Back button
    backButton = CustomButton()
    backButton.configure(title: "Back", backgroundColor: .systemGreen, textColor: .white)
    
    view.addSubview(backButton)
    backButton.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.bottom.equalToSuperview().offset(-240)
}
    
}
    
    private func setupActions(){
        loginButton.addTarget(self, action: #selector(onTapLogin) , for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(onTapRegister), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(onTapBack), for: .touchUpInside)
    }
    
}

//MARK: - Actions
extension LoginVC {
    
    @objc private func onTapLogin() {
        let isEmailValid = emailTextField.validate(with: "Please enter your email.")
        let isPasswordValid = passwordTextField.validate(with: "Please enter your password.")
        
        guard isEmailValid, isPasswordValid else {
            print("Validation failed.")
            return
        }
        
        viewModel.login(email: emailTextField.text!, password: passwordTextField.text!) { isSuccess in
            switch isSuccess {
            case true:
                self.coordinator?.showDashboard()
            case false:
                print("Login failed")
            }
        }
    }

    
    @objc func onTapRegister(){
        coordinator?.showRegister()
    }
    
    @objc func onTapBack(){
        coordinator?.pop()
    }
}
