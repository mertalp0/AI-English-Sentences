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
    
    func speak(text: String, language: String = "en-US", rate: Float = 0.5, pitchMultiplier: Float = 1.0) {
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


//let voices = AVSpeechSynthesisVoice.speechVoices()
//voices.forEach { voice in
//    print("Language: \(voice.language), Name: \(voice.name)")
//}
//
////
////  TextToSpeechManager.swift
////  AIEnglishSentences
////
////  Created by mert alp on 25.12.2024.
////
//import AVFoundation
//
//protocol TextToSpeechManagerDelegate: AnyObject {
//    func speechDidFinish()
//}
//
//final class TextToSpeechManager: NSObject {
//    static let shared = TextToSpeechManager()
//    private let synthesizer = AVSpeechSynthesizer()
//    weak var delegate: TextToSpeechManagerDelegate?
//
//    private override init() {
//        super.init()
//        synthesizer.delegate = self
//    }
//
//    func speak(text: String, language: String = "en-US") {
//        let utterance = AVSpeechUtterance(string: text)
//        utterance.voice = AVSpeechSynthesisVoice(language: language) // İngilizce için "en-US"
//        utterance.rate = 0.5 // Konuşma hızı
//        utterance.pitchMultiplier = 1.0 // Ses tonu
//        synthesizer.speak(utterance)
//    }
//
//    func stopSpeaking() {
//        synthesizer.stopSpeaking(at: .immediate)
//    }
//}
//
//extension TextToSpeechManager: AVSpeechSynthesizerDelegate {
//    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
//        delegate?.speechDidFinish()
//    }
//}
////let voices = AVSpeechSynthesisVoice.speechVoices()
////voices.forEach { voice in
////    print("Language: \(voice.language), Name: \(voice.name)")
////}
//
