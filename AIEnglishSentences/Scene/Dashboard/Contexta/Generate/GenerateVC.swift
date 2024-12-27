//
//  GenerateVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 27.12.2024.
//

import UIKit
import BaseMVVMCKit

final class GenerateVC: BaseViewController<GenerateCoordinator, GenerateViewModel> {
    
    //MARK: -  Properties
    var pageCellType: CellType?
    private var backButton: CustomButton!
    private weak var generateButton: CustomButton!
    
    
    // MARK: - UI Elements
    private var pageTitle: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Page Title
        pageTitle = UILabel()
        pageTitle.text = String(describing: type(of: self))
        pageTitle.textColor = .mainColor
        pageTitle.font = .systemFont(ofSize: 24, weight: .bold)
        pageTitle.textAlignment = .center
        view.addSubview(pageTitle)
        pageTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + 10)
        }
        
        // Generate Button
        let generateBtn = CustomButton()
        generateBtn.configure(title: "Generate", backgroundColor: .systemBlue, textColor: .white)
        view.addSubview(generateBtn)
        generateBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-120)
            make.centerX.equalToSuperview()
        }
        generateButton = generateBtn
        
        // Back Button
        backButton = CustomButton()
        backButton.configure(title: "Back", backgroundColor: .systemGreen, textColor: .white)
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-250)
        }
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(onTapBack), for: .touchUpInside)
        generateButton.addTarget(self, action: #selector(onTapGenerate), for: .touchUpInside)
        
    }
}

// MARK: - Actions
extension GenerateVC {
    @objc func onTapBack() {
        coordinator?.back()
    }
    
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
