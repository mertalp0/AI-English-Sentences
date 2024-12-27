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
    private weak var generateButton: CustomButton!
    
    // MARK: - UI Elements
    private var appBar: AppBar!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Page Title
        appBar = AppBar(type: .generate)
        appBar.delegate = self
        view.addSubview(appBar)
        appBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + 15)
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
        
 
    }
    
    private func setupActions() {
        generateButton.addTarget(self, action: #selector(onTapGenerate), for: .touchUpInside)
        
    }
}

// MARK: - Actions
extension GenerateVC {
 
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


// MARK: - AppBarDelegate
extension GenerateVC: AppBarDelegate {
    
    func leftButtonTapped() {
        coordinator?.back()
    }
    
    func rightButtonTapped() {
    }
    
}
