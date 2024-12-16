//
//  GenerateSentenceVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import UIKit
import BaseMVVMCKit

final class GenerateSentenceVC: BaseViewController<GenerateSentenceCoordinator, GenerateSentenceViewModel>{

    //MARK: - UI Elements
    private var  pageTitle : UILabel!
    private weak var generateButton: CustomButton?


    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupUI()
        setupActions()
    }
    
    private func setupUI(){
        view.backgroundColor = .white
        
        //Page Title
        pageTitle = UILabel()
        pageTitle.text = String(describing: type(of: self))
        pageTitle.textColor = .black
        
        view.addSubview(pageTitle)
        pageTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    
        let button = CustomButton()
           button.configure(title: "Generate", backgroundColor: .systemBlue, textColor: .white)
        
           view.addSubview(button)
           button.snp.makeConstraints { make in
               make.bottom.equalToSuperview().offset(-120)
               make.centerX.equalToSuperview()
           }
           generateButton = button
    }
    
    private func setupActions(){
        generateButton?.addTarget(self, action: #selector(onTapGenerate), for: .touchUpInside)
    }
}

//MARK: - Actions

extension GenerateSentenceVC {
    @objc func onTapGenerate(){
        tabBarController?.tabBar.isUserInteractionEnabled = false

        viewModel.generateSentences()
    }
}
