//
//  GenerateVC+CountSelectorViewDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

// MARK: - CountSelectorViewDelegate
extension GenerateViewController: CountSelectorViewDelegate {
    func countSelectorView(_ view: CountSelectorView, didSelectValue value: Int) {
        if view.type == .sentence {
            Logger.log("Sentence Count Selected: \(value)", type: .debug)
        } else if view.type == .word {
            Logger.log("Word Count Selected: \(value)", type: .debug)
        }
    }
}
