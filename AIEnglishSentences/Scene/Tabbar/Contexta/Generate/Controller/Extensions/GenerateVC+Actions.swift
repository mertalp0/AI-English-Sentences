//
//  GenerateVC+Actions.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

import Foundation
import RevenueCat
import RevenueCatUI

// MARK: - Actions
extension GenerateViewController {
    @objc func onTapGenerate() {
        guard let inputWords = textField.text,
              let category = pageCellType?.title,
              let maxWords = wordSelector.selectedValue,
              let sentenceCount = sentenceSelector.selectedValue else { return }

        let tone = writingTone.selectedOption ?? .localized(for: .toneFormal)
        let style = writingStyle.selectedOption ?? .localized(for: .toneFormal)

        viewModel.checkPremiumStatus { [weak self] isPremium in
            guard let self = self else { return }
            if isPremium {
                self.generateSentences(
                    inputWords: inputWords,
                    maxWords: maxWords,
                    sentenceCount: sentenceCount,
                    category: category,
                    tone: tone,
                    style: style
                )
            } else {
                self.viewModel.fetchPaywallOfferings { offering in
                    guard let offering = offering else { return }
                    self.coordinator?.presentPaywall(with: offering)
                }
            }
        }
    }

    private func generateSentences(
        inputWords: String,
        maxWords: Int,
        sentenceCount: Int,
        category: String,
        tone: String,
        style: String
    ) {
        viewModel.generateSentences(
            inputWords: inputWords,
            maxWords: maxWords,
            sentenceCount: sentenceCount,
            category: category,
            writingTone: tone,
            writingStyle: style
        ) { [weak self] result in
            switch result {
            case .success(let sentences):
                DispatchQueue.main.async {
                    self?.coordinator?.showResult(sentences: sentences)
                }
            case .failure:
                break
            }
        }
    }
}
