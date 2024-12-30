//
//  GenerateManager.swift
//  AIEnglishSentences
//
//  Created by mert alp on 23.12.2024.
//

import Foundation

final class SentenceManager {
    // Singleton Instance
    static let shared = SentenceManager()

    // Notification Names
    static let sentencesUpdatedNotification = Notification.Name("SentenceManager.sentencesUpdated")
    
    // Data Storage
    private(set) var sentences: [NewSentence] = []

    private init() {}

    // Load Sentences (Service Call)
    func loadSentences(_ newSentences: [NewSentence]) {
        sentences = newSentences
        notifySentencesUpdated()
    }

    // Güncelleme İşlemi
     func updateSentence(_ sentence: NewSentence, at index: Int) {
         guard index >= 0 && index < sentences.count else { return }
         sentences[index] = sentence
         notifySentencesUpdated()
     }

    // Add Sentence
    func addSentence(_ sentence: NewSentence) {
        sentences.append(sentence)
        notifySentencesUpdated()
    }
    

    // Notify Observers
    private func notifySentencesUpdated() {
        NotificationCenter.default.post(name: SentenceManager.sentencesUpdatedNotification, object: nil)
    }
}
