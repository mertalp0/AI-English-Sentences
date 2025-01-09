//
//  PaywallViewModel.swift
//  AIEnglishSentences
//
//  Created by mert alp on 7.01.2025.
//

import BaseMVVMCKit
import RevenueCat

final class PaywallViewModel: BaseViewModel {
    
    private let subscriptionService = SubscriptionService.shared
    
    func fetchPackages(completion: @escaping ([Package]?) -> Void) {
        subscriptionService.fetchPackages { packages in
            completion(packages)
        }
    }
    
    func purchase(package: Package, completion: @escaping (Bool) -> Void) {
        subscriptionService.purchase(package: package) { success in
            completion(success)
        }
    }
}
