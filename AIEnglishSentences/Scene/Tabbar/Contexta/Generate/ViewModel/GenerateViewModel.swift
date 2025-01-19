//
//  GenerateViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 27.12.2024.
//

import BaseMVVMCKit
import Foundation
import RevenueCat

final class GenerateViewModel: BaseViewModel {

    let openAIService = OpenAIService()
    let subscriptionService = SubscriptionService.shared

    func generateSentences(
        inputWords: String,
        maxWords: Int,
        sentenceCount: Int,
        category: String,
        writingTone: String,
        writingStyle: String,
        completion: @escaping (Result<[Sentence], Error>) -> Void
    ) {
        if inputWords.isEmpty {
            handleError(message: .localized(for: .generateInputError))
            return
        }
        startLoading()

        openAIService
            .generateSentences(
                inputWords: inputWords,
                maxWords: maxWords,
                sentenceCount: sentenceCount,
                category: category,
                writingTone: writingTone,
                writingStyle: writingStyle
            ) { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                switch result {
                case .success(let sentences):
                    self.stopLoading()
                    Logger.log("Generated Sentences: \(sentences)", type: .info)
                    completion(.success(sentences))
                case .failure(let error):
                    self.stopLoading()
                    self.handleError(message: error.localizedDescription)
                    Logger.log("Error: \(error.localizedDescription)", type: .error)
                    completion(.failure(error))
                }
            }
        }
    }

    func checkPremiumStatus(completion: @escaping (Bool) -> Void) {
        subscriptionService.checkPremiumStatus(completion: completion)
    }

    func fetchPaywallOfferings(completion: @escaping (Offering?) -> Void) {
        Purchases.shared.getOfferings { offerings, error in
            if let error = error {
                Logger.log("Failed to fetch offerings: \(error.localizedDescription)", type: .error)
                completion(nil)
                return
            }

            guard let currentOffering = offerings?.current else {
                Logger.log("No current offering found.", type: .info)
                completion(nil)
                return
            }

            Logger.log("Successfully fetched current offering.", type: .info)
            completion(currentOffering)
        }
    }
}
