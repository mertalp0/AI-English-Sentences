//
//  SentenceManager.swift
//  AIEnglishSentences
//
//  Created by mert alp on 23.12.2024.
//

import Foundation

final class SentenceManager {
    static let shared = SentenceManager()

    static let sentencesUpdatedNotification = Notification.Name("SentenceManager.sentencesUpdated")
    
    private(set) var sentences: [Sentence] = []

    private init() {}

    func loadSentences(_ newSentences: [Sentence]) {
        sentences = newSentences
        notifySentencesUpdated()
    }

    func updateSentence(_ sentence: Sentence, at index: Int) {
        guard index >= 0 && index < sentences.count else { return }
        sentences[index] = sentence
        notifySentencesUpdated()
    }

    func addSentence(_ sentence: Sentence) {
        if !sentences.contains(where: { $0.id == sentence.id }) {
            sentences.append(sentence)
            notifySentencesUpdated()
        }
    }
    
    func removeSentence(at index: Int) {
        guard index >= 0 && index < sentences.count else { return }
        sentences.remove(at: index)
        notifySentencesUpdated()
    }
    
    func removeSentence(by id: String) {
        if let index = sentences.firstIndex(where: { $0.id == id }) {
            sentences.remove(at: index)
            notifySentencesUpdated()
        }
    }
    
    private func notifySentencesUpdated() {
        NotificationCenter.default.post(name: SentenceManager.sentencesUpdatedNotification, object: nil)
    }
}
