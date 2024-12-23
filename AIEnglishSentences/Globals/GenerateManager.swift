//
//  GenerateManager.swift
//  AIEnglishSentences
//
//  Created by mert alp on 23.12.2024.
//

import Foundation
import NotificationCenter

final class GenerateManager {
    static let shared = GenerateManager()
    private init() {}

    var generateModels: [GenerateModel] = [] {
        didSet {
            NotificationCenter.default.post(name: .generateModelsUpdated, object: nil)
        }
    }

    func addGenerateModel(_ model: GenerateModel) {
        generateModels.append(model)
    }

    func removeGenerateModel(at index: Int) {
        guard index < generateModels.count else { return }
        generateModels.remove(at: index)
    }
}

extension Notification.Name {
    static let generateModelsUpdated = Notification.Name("generateModelsUpdated")
}
