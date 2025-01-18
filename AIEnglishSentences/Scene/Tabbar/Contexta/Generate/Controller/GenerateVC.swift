//
//  GenerateVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 27.12.2024.
//

import UIKit
import BaseMVVMCKit
import RevenueCat
import RevenueCatUI

final class GenerateVC: BaseViewController<GenerateCoordinator, GenerateViewModel> {
    
    // MARK: - Properties
    var pageCellType: CellType!
    
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
        view.backgroundColor = .background
        
        // AppBar
        appBar = AppBar(type: .generate(pageCellType: pageCellType))
        appBar.delegate = self
        view.addSubview(appBar)
        appBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + UIHelper.dynamicHeight(10))
        }
        
        // Question Label
        questionLabel = UILabel()
        questionLabel.text = .localized(for: .generateTitle)
        questionLabel.textColor = .main
        questionLabel.font = .dynamicFont(size: 20, weight: .light)
        view.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalTo(appBar.snp.bottom).offset(UIHelper.dynamicHeight(13))
        }
        
        // Text Field
        textField = GenerateTextView()
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(UIHelper.dynamicHeight(16))
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(UIHelper.dynamicHeight(160))
        }
        
        writingTone = DropdownMenuButton(
            title: .localized(for: .writingToneTitle),
            options: [
                .localized(for: .toneFormal),
                .localized(for: .toneFriendly),
                .localized(for: .toneCasual),
                .localized(for: .toneInspirational),
                .localized(for: .toneHumorous)
                
            ]
        )
        writingTone.onDropdownTapped = { [weak self] in
            self?.view.endEditing(true)
        }
        writingTone.onOptionSelected = { selectedOption in
            print("Selected Writing Tone: \(selectedOption)")
        }
        view.addSubview(writingTone)
        writingTone.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(UIHelper.dynamicHeight(8))
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(UIHelper.dynamicHeight(60))
        }
        
        writingStyle = DropdownMenuButton(
            title: .localized(for: .writingStyleTitle),
            options: [
                .localized(for: .stylePersuasive),
                .localized(for: .styleNarrative),
                .localized(for: .styleDescriptive),
                .localized(for: .styleExplanatory),
                .localized(for: .styleCreative)
            ]
        )
        writingStyle.onDropdownTapped = { [weak self] in
            self?.view.endEditing(true)
        }
        writingStyle.onOptionSelected = { selectedOption in
            print("Selected Writing Style: \(selectedOption)")
        }
        view.addSubview(writingStyle)
        writingStyle.snp.makeConstraints { make in
            make.top.equalTo(writingTone.snp.bottom).offset(UIHelper.dynamicHeight(8))
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(UIHelper.dynamicHeight(60))
        }
        
        // Sentence Selector
        sentenceSelector = CountSelectorView(type: .sentence)
        sentenceSelector.delegate = self
        view.addSubview(sentenceSelector)
        sentenceSelector.snp.makeConstraints { make in
            make.top.equalTo(writingStyle.snp.bottom).offset(UIHelper.dynamicHeight(8))
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        // Word Selector
        wordSelector = CountSelectorView(type: .word)
        wordSelector.delegate = self
        view.addSubview(wordSelector)
        wordSelector.snp.makeConstraints { make in
            make.top.equalTo(sentenceSelector.snp.bottom).offset(UIHelper.dynamicHeight(8))
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        // Generate Button
        let generateBtn = GenerateButton()
        view.addSubview(generateBtn)
        generateBtn.snp.makeConstraints { make in
            make.top.equalTo(wordSelector.snp.bottom).offset(UIHelper.dynamicHeight(22))
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
        guard generateButton != nil else { return }
        
        let inputWords = textField.text ?? ""
        let maxWords = wordSelector.selectedValue
        let sentenceCount = sentenceSelector.selectedValue
        let category = pageCellType?.title
        let tone = writingTone.selectedOption ?? .localized(for: .toneFormal)
        let style = writingStyle.selectedOption ?? .localized(for: .toneFormal)
        
        
        SubscriptionService.shared.checkPremiumStatus { isPremium in
#warning("Should be based on isPremium")
            if(true){
                
                self.viewModel.generateSentences(
                    inputWords: inputWords,
                    maxWords: maxWords ?? 10,
                    sentenceCount: sentenceCount ?? 1,
                    category: category ?? .localized(for: .categoryPersonalTitle),
                    writingTone: tone,
                    writingStyle: style
                ) { result in
                    switch result {
                    case .success(let sentences):
                        DispatchQueue.main.async {
                            self.coordinator?.showResult(sentences: sentences)
                        }
                    case .failure(let error):
                        print("generateSentences Error: \(error)")
                    }
                }
            }
            else{
                Purchases.shared.getOfferings { [weak self] (offerings, error) in
                    guard let self = self else { return }
                    
                    if error != nil {
                        return
                    }
                    
                    guard let currentOffering = offerings?.current else {
                        return
                    }
                    
                    let paywallVC = PaywallViewController(offering: currentOffering)
                    self.present(paywallVC, animated: true, completion: nil)
                }
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
        // Right button action
    }
}

// MARK: - CountSelectorViewDelegate
extension GenerateVC: CountSelectorViewDelegate {
    func countSelectorView(_ view: CountSelectorView, didSelectValue value: Int) {
        if view.type == .sentence {
            print("Sentence Count Selected: \(value)")
        } else if view.type == .word {
            print("Word Count Selected: \(value)")
        }
    }
}
