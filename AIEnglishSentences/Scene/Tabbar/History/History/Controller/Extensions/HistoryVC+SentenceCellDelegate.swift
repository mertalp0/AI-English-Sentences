//
//  HistoryVC+SentenceCellDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

import UIKit

// MARK: - SentenceCellDelegate
extension HistoryViewController: SentenceCellDelegate {
    func didTapCopyButton(for sentence: String, in cell: SentenceCell) {
        UIPasteboard.general.string = sentence
        showToast(message: .localized(for: .historyCopiedToClipboard))
    }

    func didTapSaveAndFavorite(for sentence: Sentence, in cell: SentenceCell) {

        if let indexInAllData = SentenceManager.shared.sentences.firstIndex(where: { $0.id == sentence.id }) {
            var updatedSentence = sentence
            updatedSentence.favorite.toggle()

            if updatedSentence.favorite {
                viewModel.addFavoriteSentence(sentence: updatedSentence) { [weak self] isSuccess in
                    guard let self = self else { return }
                    if isSuccess {
                        if !self.favouritesData.contains(where: { $0.id == updatedSentence.id }) {
                            self.favouritesData.append(updatedSentence)
                        }
                        SentenceManager.shared.updateSentence(updatedSentence, at: indexInAllData)
                        self.updateUIForCurrentData()
                    }
                }
            } else {
                viewModel.deleteFavoriteSentence(sentence: updatedSentence) { [weak self] isSuccess in
                    guard let self = self else { return }
                    if isSuccess {
                        if let indexInFavorites = self.favouritesData.firstIndex(where: { $0.id == updatedSentence.id }) {
                            self.favouritesData.remove(at: indexInFavorites)
                        }
                        SentenceManager.shared.updateSentence(updatedSentence, at: indexInAllData)
                        self.updateUIForCurrentData()
                    }
                }
            }
        }
    }

    func didTapPlayButton(for sentence: String, in cell: SentenceCell) {
        if let currentlyPlayingCell = currentlyPlayingCell, currentlyPlayingCell == cell {
            stopCurrentSpeaking()
        } else {
            stopCurrentSpeaking()
            textToSpeechManager.speak(text: sentence)
            cell.updatePlayButton(isPlaying: true)
            currentlyPlayingCell = cell
        }
    }

    func didTapDelete(for sentence: Sentence, in cell: SentenceCell) {
        let alertController = UIAlertController(
            title: .localized(for: .historyDeleteAlertTitle),
            message: .localized(for: .historyDeleteAlertMessage),
            preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(
            title: .localized(for: .historyDeleteAlertCancel),
            style: .cancel,
            handler: nil
        ))
        alertController.addAction(UIAlertAction(
            title: .localized(for: .historyDeleteAlertConfirm),
            style: .destructive
        ) { [weak self] _ in
            self?.deleteSentence(sentence: sentence)
        })

        present(alertController, animated: true, completion: nil)
    }

    private func deleteSentence(sentence: Sentence) {
        viewModel.deleteSentence(sentence: sentence) { [weak self] isSuccess in
            if isSuccess {
                self?.loadInitialData()
                self?.updateUIForCurrentData()
            }
        }
    }
}
