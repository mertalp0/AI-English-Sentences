//
//  GenerateSentenceVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import UIKit
import BaseMVVMCKit

final class GenerateSentenceVC: BaseViewController<GenerateSentenceCoordinator, GenerateSentenceViewModel> {
    
    // MARK: - UI Elements
    private var pageTitle: UILabel!
    private weak var generateButton: CustomButton?
    private weak var saveSentencesButton: CustomButton?
    
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
        let generateBtn = CustomButton()
        generateBtn.configure(title: "Generate", backgroundColor: .systemBlue, textColor: .white)
        view.addSubview(generateBtn)
        generateBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-120)
            make.centerX.equalToSuperview()
        }
        generateButton = generateBtn
        
        // Save Sentences Button
        let saveBtn = CustomButton()
        saveBtn.configure(title: "Save Sentences", backgroundColor: .systemGreen, textColor: .white)
        view.addSubview(saveBtn)
        saveBtn.snp.makeConstraints { make in
            make.bottom.equalTo(generateBtn.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }
        saveSentencesButton = saveBtn
    }
    
    private func setupActions() {
        generateButton?.addTarget(self, action: #selector(onTapGenerate), for: .touchUpInside)
        saveSentencesButton?.addTarget(self, action: #selector(onTapSaveSentences), for: .touchUpInside)
    }
}

// MARK: - Actions
extension GenerateSentenceVC {
    @objc private func onTapGenerate() {
        
        guard let button = generateButton else { return }
        print("Generate button tapped: \(button)")
        viewModel.generateSentences { isSucces in
            switch isSucces{
            case true:
                DispatchQueue.main.async {
                    self.coordinator?.showResult()
                }
            default:
                print(" generateSentences Error")
            }
            
        }
    }
    
    @objc private func onTapSaveSentences() {
        guard let button = saveSentencesButton else { return }
        print("Save Sentences button tapped: \(button)")
     
    }
}
