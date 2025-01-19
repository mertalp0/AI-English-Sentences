//
//  TextToSpeechManager.swift
//  AIEnglishSentences
//
//  Created by mert alp on 25.12.2024.
//

import AVFoundation

final class TextToSpeechManager {
    private let synthesizer = AVSpeechSynthesizer()
    static let shared = TextToSpeechManager()

    private init() {}

    func speak(
        text: String,
        language: String = "en-US",
        rate: Float = 0.5,
        pitchMultiplier: Float = 1.0
    ) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = rate
        utterance.pitchMultiplier = pitchMultiplier

        synthesizer.speak(utterance)
    }

    func stopSpeaking() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
    }
}
