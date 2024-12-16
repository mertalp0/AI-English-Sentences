//
//  ProfileVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import UIKit
import BaseMVVMCKit

final class ProfileVC: BaseViewController<ProfileCoordinator, ProfileViewModel>{
    
    //MARK: - UI Elements
    private var  pageTitle : UILabel!
    private var  logoutButton : CustomButton!
 
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
        
        //logout Button
        logoutButton = CustomButton()
        logoutButton.configure(title: "Logout", backgroundColor: .systemGreen, textColor: .white)
        
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-250)
        }
    }
    
    private func setupActions(){
        logoutButton.addTarget(self, action: #selector(onTapLogout) , for: .touchUpInside)
        
    }
}

//MARK: - Actions
extension ProfileVC {
    
    @objc func onTapLogout(){
        coordinator?.showInfo()
    }
}
