//
//  SentenceManager.swift
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

    // Update Sentence
    func updateSentence(_ sentence: NewSentence, at index: Int) {
        guard index >= 0 && index < sentences.count else { return }
        sentences[index] = sentence
        notifySentencesUpdated()
    }

    // Add Sentence
    func addSentence(_ sentence: NewSentence) {
        if !sentences.contains(where: { $0.id == sentence.id }) {
            sentences.append(sentence)
            notifySentencesUpdated()
        }
    }
    
    // Remove Sentence by Index
    func removeSentence(at index: Int) {
        guard index >= 0 && index < sentences.count else { return }
        sentences.remove(at: index)
        notifySentencesUpdated()
    }
    
    // Remove Sentence by ID
    func removeSentence(by id: String) {
        if let index = sentences.firstIndex(where: { $0.id == id }) {
            sentences.remove(at: index)
            notifySentencesUpdated()
        }
    }
    
    // Notify Observers
    private func notifySentencesUpdated() {
        NotificationCenter.default.post(name: SentenceManager.sentencesUpdatedNotification, object: nil)
    }
}
