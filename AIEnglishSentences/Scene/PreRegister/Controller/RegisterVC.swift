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
    private var  pageTitle : UILabel!
    private var  loginButton : CustomButton!
    private var  registerButton : CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupActions()
    }
    
    //MARK: - Deinit
    deinit {
        print("\(self) deallocated")
    }
    
    
    
    
    private func setupUI(){
        
        //Page Title
        pageTitle = UILabel()
        pageTitle.text = "register vc"
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
    }
    
    private func setupActions(){
        loginButton.addTarget(self, action: #selector(onTapLogin) , for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(onTapRegister), for: .touchUpInside)
    }
}

//MARK: - Actions
extension RegisterVC {
    
    @objc func onTapLogin(){
        viewModel.register()
    }
    
    @objc func onTapRegister(){
      
    }
}
