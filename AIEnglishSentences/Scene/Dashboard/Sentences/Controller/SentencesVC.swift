//
//  SentencesVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 24.12.2024.
//

import UIKit
import BaseMVVMCKit

final class SentencesVC: BaseViewController<SentencesCoordinator, SentencesViewModel>{
    
    //MARK: - Properties
    var sentences: [String] = []
    
    //MARK: - UI Elements
    private var  pageTitle : UILabel!
    private var sentencesTableView: SentencesTableView!

    private var  backButton : CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupActions()
        configureTableView()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        TextToSpeechManager.shared.stopSpeaking()
    }
    
    private func setupUI(){
        
        //Page Title
        pageTitle = UILabel()
        pageTitle.text = String(describing: type(of: self))
        pageTitle.textColor = .black
        view.addSubview(pageTitle)
        pageTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + 10)
        }
        
        
        //backButton Button
        backButton = CustomButton()
        backButton.configure(title: "Back", backgroundColor: .systemGreen, textColor: .white)
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
        
        // Sentences TableView
        sentencesTableView = SentencesTableView()
        view.addSubview(sentencesTableView)
        sentencesTableView.snp.makeConstraints { make in
            make.top.equalTo(pageTitle.snp.bottom)
            make.bottom.equalTo(backButton.snp.top)
            make.left.right.equalToSuperview()
        }
    }
    
    private func setupActions(){
        backButton.addTarget(self, action: #selector(onTapBack) , for: .touchUpInside)
        
    }
    
    private func configureTableView() {
        sentencesTableView.configure(with: self.sentences)
    }
}

//MARK: - Actions
extension SentencesVC {
    
    @objc func onTapBack(){
        coordinator?.back()
    }
}
