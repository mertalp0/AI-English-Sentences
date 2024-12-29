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
    
    // MARK: - UI Elements
    private weak var generateButton: GenerateButton!
    private var questionLabel: UILabel!
    private var textField: GenerateTextView!
    private var sentenceSelector: CountSelectorView!
    private var wordSelector: CountSelectorView!
    private var writingTone: DropdownMenuButton!
    private var writingStyle: DropdownMenuButton!
    private var appBar: AppBar!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        setupKeyboardDismissRecognizer()
    }
    
    private func setupUI() {
        view.backgroundColor = .init(hex: "F2F2F2")
        
        appBar = AppBar(type: .generate)
        appBar.delegate = self
        view.addSubview(appBar)
        appBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + 10)
        }
        
        questionLabel = UILabel()
        questionLabel.text = "What will you generate today?"
        questionLabel.font = .systemFont(ofSize: 20, weight: .light)
        view.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalTo(appBar.snp.bottom).offset(13)
        }
        
        textField = GenerateTextView()
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(160)
        }
        
        writingTone  = DropdownMenuButton(title: "Writing Tone", options: ["Default (Formal)", "Friendly", "Casual", "Academic"])
        writingTone.onDropdownTapped = { [weak self] in
                   self?.view.endEditing(true)
               }
        writingTone.onOptionSelected = { selectedOption in
            print("Selected Option: \(selectedOption)")
        }
        
        view.addSubview(writingTone)
    
        writingTone.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(70)
        }
        
        writingStyle = DropdownMenuButton(title: "Writing Tone", options: ["Default (Formal)", "Friendly", "Casual", "Academic"])
        writingTone.onDropdownTapped = { [weak self] in
                   self?.view.endEditing(true)
               }
        writingStyle.onOptionSelected = { selectedOption in
            print("Selected Option: \(selectedOption)")
        }
        
        view.addSubview(writingStyle)
    
        writingStyle.snp.makeConstraints { make in
            make.top.equalTo(writingTone.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(70)
        }
    
        sentenceSelector = CountSelectorView(type: .sentence)
        sentenceSelector.delegate = self
        view.addSubview(sentenceSelector)
        sentenceSelector.snp.makeConstraints { make in
            make.top.equalTo(writingStyle.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        
        wordSelector = CountSelectorView(type: .word)
        wordSelector.delegate = self
        view.addSubview(wordSelector)
        wordSelector.snp.makeConstraints { make in
            make.top.equalTo(sentenceSelector.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        let generateBtn = GenerateButton()
        view.addSubview(generateBtn)
        generateBtn.snp.makeConstraints { make in
            make.top.equalTo(wordSelector.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        generateButton = generateBtn
        
    }
    
    private func setupActions() {
        generateButton.addTarget(self, action: #selector(onTapGenerate), for: .touchUpInside)
        
    }
    
    override func showLoading() {
           DispatchQueue.main.async {
               if self.loadingView == nil {
                   self.loadingView = GenerateLoadingView(frame: self.view.bounds) 
                   self.loadingView?.alpha = 0
                   self.view.addSubview(self.loadingView!)
                   
                   UIView.animate(withDuration: 0.3) {
                       self.loadingView?.alpha = 1
                   }
               }
           }
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

extension GenerateVC: CountSelectorViewDelegate {
    func countSelectorView(_ view: CountSelectorView, didSelectValue value: Int) {
        print("Seçilen değer: \(value)")
        
        if view.type == .sentence {
            print("Sentence Count seçildi: \(value)")
        } else if view.type == .word {
            print("Word Count seçildi: \(value)")
        }
    }
}
