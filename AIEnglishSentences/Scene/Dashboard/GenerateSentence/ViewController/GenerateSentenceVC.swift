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
        
    }
    
    private func setupActions() {
        generateButton?.addTarget(self, action: #selector(onTapGenerate), for: .touchUpInside)
    }
}

// MARK: - Actions
extension GenerateSentenceVC {
    @objc private func onTapGenerate() {
        
        guard let button = generateButton else { return }
        print("Generate button tapped: \(button)")
        viewModel.generateSentences { result in
            switch result{
            case .success(let generateModel):
                
                DispatchQueue.main.async {
                    self.coordinator?.showResult(generateModel: generateModel)
                }
            default:
                print("generateSentences Error")
            }
            
        }
    }
    
}
