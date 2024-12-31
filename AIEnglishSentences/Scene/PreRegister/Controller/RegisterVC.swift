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
    
    //MARK: - UI Elements
    private var pageTitle : UILabel!
    private var loginButton : CustomButton!
    private var registerButton : CustomButton!
    private var backButton : CustomButton!
    private var emailTextField : CustomTextField!
    private var passwordTextField : CustomTextField!
    private var nameTextField : CustomTextField!
    private var gender : Gender = .preferNotToSay
    
    
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
    
        // Name TextField
        nameTextField = CustomTextField()
        nameTextField.configure(placeholder: "Enter your Name",type: .normal)
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        // Password TextField
        passwordTextField = CustomTextField()
        passwordTextField.configure(placeholder: "Enter your password",type: .password)
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
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
        
        //Login button
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
extension RegisterVC {
    
    @objc func onTapLogin(){
        coordinator?.showLogin()
    }
    
    @objc func onTapRegister(){
        let isEmailValid = emailTextField.validate(with: "Please enter your email.")
        let isNameValid = nameTextField.validate(with: "Please enter your name.")
        let isPasswordValid = passwordTextField.validate(with: "Please enter your password.")
        
        guard isEmailValid, isPasswordValid, isNameValid else {
            print("Validation failed.")
            return
        }

        viewModel.register(email: emailTextField.text!, name:nameTextField.text!, password: passwordTextField.text!, gender: gender ) { isSucces in
            switch isSucces {
            case true:
                self.coordinator?.showDashboard()
                
            case false:
                print("Register failed.")
        
            }
        }
    }
    
    @objc func onTapBack(){
        coordinator?.pop()
    }
}
