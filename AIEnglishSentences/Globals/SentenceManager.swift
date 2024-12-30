////
////  SentenceManager.swift
////  AIEnglishSentences
////
////  Created by mert alp on 30.12.2024.
////
//
//import Foundation
//import Foundation
//
//final class SentenceManager {
//    // MARK: - Properties
//    static let shared = SentenceManager()
//    
//    static let sentencesUpdatedNotification = Notification.Name("sentencesUpdatedNotification")
//    
//    private init(){}
//    private(set) var sentences: [NewSentence] = []
//    
//    // MARK: - Methods
//    func addSentence(_ sentence: NewSentence) {
//        sentences.append(sentence)
//        notifySentencesUpdated()
//    }
//    
//    func removeSentence(at index: Int) {
//        guard index >= 0 && index < sentences.count else { return }
//        sentences.remove(at: index)
//        notifySentencesUpdated()
//    }
//    
//    func updateSentence(_ sentence: NewSentence, at index: Int) {
//        guard index >= 0 && index < sentences.count else { return }
//        sentences[index] = sentence
//        notifySentencesUpdated()
//    }
//    
//    func loadSentences(_ newSentences: [NewSentence]) {
//        sentences = newSentences
//        notifySentencesUpdated()
//    }
//    
//    private func notifySentencesUpdated() {
//        NotificationCenter.default.post(name: SentenceManager.sentencesUpdatedNotification, object: nil)
//    }
//}
