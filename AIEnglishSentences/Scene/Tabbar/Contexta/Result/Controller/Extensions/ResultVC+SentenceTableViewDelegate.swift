//
//  ResultVC+SentenceTableViewDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

import UIKit

extension ResultViewController: SentenceTableViewDelegate {
    func didTapCopyButton(for sentence: String, in cell: SentenceCell) {
        UIPasteboard.general.string = sentence
        showToast(message: .localized(for: .resultCopyToClipboard))
    }

    func didTapSave(for sentence: Sentence, in cell: SentenceCell) {
        if SentenceManager.shared.sentences.contains(where: { $0.id == sentence.id }) {

            viewModel.deleteSentence(sentence: sentence) { [weak self] isSuccess in
                guard let self = self else { return }
                if isSuccess {
                    cell.updateSaveAndFavoriteButton(for: sentence)
                    self.showAlert(
                        title: .localized(for: .resultSuccessTitle),
                        message: .localized(for: .resultSentenceRemovedSuccess)
                    )
                } else {
                    self.showAlert(
                        title: .localized(for: .resultSuccessTitle),
                        message: .localized(for: .resultSentenceRemovedError)
                    )
                }
            }
        } else {
            viewModel.saveSentence(sentence: sentence) { [weak self] isSuccess in
                guard let self = self else { return }
                if isSuccess {
                    cell.updateSaveAndFavoriteButton(for: sentence)
                    self.showAlert(
                        title: .localized(for: .resultSuccessTitle),
                        message: .localized(for: .resultSentenceSavedSuccess)
                    )
                } else {
                    self.showAlert(
                        title: .localized(for: .resultSuccessTitle),
                        message: .localized(for: .resultSentenceSavedError)
                    )
                }
            }
        }
    }
}
