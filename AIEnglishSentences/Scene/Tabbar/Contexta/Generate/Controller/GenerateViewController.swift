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

final class GenerateViewController: BaseViewController<GenerateCoordinator, GenerateViewModel> {

    // MARK: - Properties
    var pageCellType: CellType!

    // MARK: - UI Elements
    weak var generateButton: GenerateButton!
    var questionLabel: UILabel!
    var textField: GenerateTextView!
    var sentenceSelector: CountSelectorView!
    var wordSelector: CountSelectorView!
    var writingTone: DropdownMenuButton!
    var writingStyle: DropdownMenuButton!
    var appBar: AppBar!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        setupKeyboardDismissRecognizer()
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

// MARK: - UI Setup
private extension GenerateViewController {

    private func setupUI() {
        view.backgroundColor = .background
        setupAppBar()
        setupQuestionLabel()
        setupTextField()
        setupWritingTone()
        setupWritingStyle()
        setupSentenceSelector()
        setupWordSelector()
        setupGenerateButton()
    }

    private func setupAppBar() {
        appBar = AppBar(type: .generate(pageCellType: pageCellType))
        appBar.delegate = self
        view.addSubview(appBar)
        appBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + UIHelper.dynamicHeight(10))
        }
    }

    private func setupQuestionLabel() {
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
    }

    private func setupTextField() {
        textField = GenerateTextView()
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(UIHelper.dynamicHeight(16))
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(UIHelper.dynamicHeight(160))
        }
    }

    private  func setupWritingTone() {
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
        view.addSubview(writingTone)
        writingTone.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(UIHelper.dynamicHeight(8))
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(UIHelper.dynamicHeight(60))
        }
    }

    private func setupWritingStyle() {
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
        view.addSubview(writingStyle)
        writingStyle.snp.makeConstraints { make in
            make.top.equalTo(writingTone.snp.bottom).offset(UIHelper.dynamicHeight(8))
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(UIHelper.dynamicHeight(60))
        }
    }

    private func setupSentenceSelector() {
        sentenceSelector = CountSelectorView(type: .sentence)
        sentenceSelector.delegate = self
        view.addSubview(sentenceSelector)
        sentenceSelector.snp.makeConstraints { make in
            make.top.equalTo(writingStyle.snp.bottom).offset(UIHelper.dynamicHeight(8))
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
    }

    private func setupWordSelector() {
        wordSelector = CountSelectorView(type: .word)
        wordSelector.delegate = self
        view.addSubview(wordSelector)
        wordSelector.snp.makeConstraints { make in
            make.top.equalTo(sentenceSelector.snp.bottom).offset(UIHelper.dynamicHeight(8))
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
    }

    private func setupGenerateButton() {
        let generateBtn = GenerateButton()
        view.addSubview(generateBtn)
        generateBtn.snp.makeConstraints { make in
            make.top.equalTo(wordSelector.snp.bottom).offset(UIHelper.dynamicHeight(22))
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        generateButton = generateBtn
    }
}
