//
//  HistoryVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import UIKit
import BaseMVVMCKit

final class HistoryVC: BaseViewController<HistoryCoordinator, HistoryViewModel>{
    
    // MARK: - UI Elements
    private var pageTitle: UILabel!
    private weak var getSentencesButton: CustomButton?
    private weak var deleteSentencesButton: CustomButton?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }

    private func setupUI() {
        view.backgroundColor = .white

        // Page Title
        let titleLabel = UILabel()
        titleLabel.text = String(describing: type(of: self))
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        pageTitle = titleLabel

        // Generate Button
        let getSentencesBtn = CustomButton()
        getSentencesBtn.configure(title: "Get Sentences", backgroundColor: .systemBlue, textColor: .white)
        view.addSubview(getSentencesBtn)
        getSentencesBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-120)
            make.centerX.equalToSuperview()
        }
        getSentencesButton = getSentencesBtn

        // Save Sentences Button
        let deleteSentencesBtn = CustomButton()
        deleteSentencesBtn.configure(title: "Delete Sentences", backgroundColor: .systemGreen, textColor: .white)
        view.addSubview(deleteSentencesBtn)
        deleteSentencesBtn.snp.makeConstraints { make in
            make.bottom.equalTo(getSentencesBtn.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }
        deleteSentencesButton = deleteSentencesBtn
    }

    private func setupActions() {
        getSentencesButton?.addTarget(self, action: #selector(onTapGetSentences), for: .touchUpInside)
        deleteSentencesButton?.addTarget(self, action: #selector(onTaDeleteSentences), for: .touchUpInside)
    }
}

// MARK: - Actions
extension HistoryVC {
    @objc private func onTapGetSentences() {
        guard let button = getSentencesButton else { return }
        print("Get Sentences Button tapped: \(button)")
        
    }

    @objc private func onTaDeleteSentences() {
        guard let button = deleteSentencesButton else { return }
        print("Delete Sentences Button tapped: \(button)")
     
    }
}
