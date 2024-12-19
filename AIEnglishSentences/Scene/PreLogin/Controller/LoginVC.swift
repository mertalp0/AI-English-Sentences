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
    private var  pageTitle : UILabel!
    private var  loginButton : CustomButton!
    private var  registerButton : CustomButton!
    private var  backButton : CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupActions()
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
extension LoginVC {
    
    @objc func onTapLogin(){
        
        viewModel.login(email: "mertalp@gmail.com", password: "123123") { isSucces in
            switch isSucces {
            case true:
                self.coordinator?.showDashboard()
                
            case false:
                print("Kayıt sırasında bir hata oluştu.")
                
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
