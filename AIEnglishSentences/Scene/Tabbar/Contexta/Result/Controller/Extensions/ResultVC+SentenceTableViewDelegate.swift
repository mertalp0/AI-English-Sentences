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

    func didTapSave(
        for sentence: Sentence,
        in cell: SentenceCell
    ) {
        let isSentenceSaved = SentenceManager.shared.sentences.contains { $0.id == sentence.id }

        if isSentenceSaved {
            handleSentenceDeletion(for: sentence, in: cell)
        } else {
            handleSentenceSaving(for: sentence, in: cell)
        }
    }

    private func handleSentenceDeletion(
        for sentence: Sentence,
        in cell: SentenceCell
    ) {
        viewModel.deleteSentence(sentence: sentence) { [weak self] isSuccess in
            guard let self = self else { return }
            self.handleSaveResult(isSuccess: isSuccess, isSaving: false, for: sentence, in: cell)
        }
    }

    private func handleSentenceSaving(
        for sentence: Sentence,
        in cell: SentenceCell
    ) {
        viewModel.saveSentence(sentence: sentence) { [weak self] isSuccess in
            guard let self = self else { return }
            self.handleSaveResult(isSuccess: isSuccess, isSaving: true, for: sentence, in: cell)
        }
    }

    private func handleSaveResult(
        isSuccess: Bool,
        isSaving: Bool,
        for sentence: Sentence,
        in cell: SentenceCell
    ) {
        cell.updateSaveAndFavoriteButton(for: sentence)

        let title: String = .localized(for: .resultSuccessTitle)
        let message: String = isSaving
            ? (isSuccess ? .localized(for: .resultSentenceSavedSuccess) : .localized(for: .resultSentenceSavedError))
            : (isSuccess ? .localized(for: .resultSentenceRemovedSuccess) : .localized(for: .resultSentenceRemovedError))

        showAlert(title: title, message: message)
    }
}
