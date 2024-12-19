//
//  ResultVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.12.2024.
//

import UIKit
import BaseMVVMCKit

final class ResultVC: BaseViewController<ResultCoordinator, ResultViewModel>{
    
    //MARK: - UI Elements
    private var  pageTitle : UILabel!
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
        
        //back Button
        backButton = CustomButton()
        backButton.configure(title: "Back", backgroundColor: .systemGreen, textColor: .white)
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-250)
        }
    }
    
    private func setupActions(){
        backButton.addTarget(self, action: #selector(onTapBack) , for: .touchUpInside)
        
    }
}

//MARK: - Actions
extension ResultVC {
    
    @objc func onTapBack(){
        coordinator?.back()
    }
}
