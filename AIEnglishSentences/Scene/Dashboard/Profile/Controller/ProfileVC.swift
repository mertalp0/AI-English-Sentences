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
    private var  IqtestButton : CustomButton!
    
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
        
        //IQ-Test Button
        IqtestButton = CustomButton()
        IqtestButton.configure(title: "IqtestButton", backgroundColor: .blue, textColor: .white)
        
        view.addSubview(IqtestButton)
        IqtestButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-150)
        }
    }
    
    private func setupActions(){
        logoutButton.addTarget(self, action: #selector(onTapLogout) , for: .touchUpInside)
        IqtestButton.addTarget(self, action: #selector(onTapIqTest) , for: .touchUpInside)

        
    }
}

//MARK: - Actions
extension ProfileVC {
    
    @objc private func onTapLogout(){
        tabBarController?.tabBar.isUserInteractionEnabled = false
        viewModel.logout { isSucces in
            switch isSucces {
            case true:
                self.coordinator?.showInfo()
                
            case false:
                self.tabBarController?.tabBar.isUserInteractionEnabled = true
                print("Kayıt sırasında bir hata oluştu.")
            }
        }
    }
    
    @objc private func onTapIqTest() {
        print("IQ Test Button tapped")
        viewModel.openIqTestApp { success in
            if success {
                print("Uygulama açıldı veya App Store yönlendirmesi yapıldı.")
            } else {
                print("Uygulama açma işlemi başarısız.")
            }
        }
    }
}
