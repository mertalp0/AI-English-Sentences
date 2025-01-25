//
//  SubscriptionService.swift
//  AIEnglishSentences
//
//  Created by mert alp on 7.01.2025.
//

import RevenueCat
import FirebaseAuth

class SubscriptionService {
    static let shared = SubscriptionService()
    private let apiKey: String

    init() {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "REVENUE_CAT_KEY") as? String else {
            fatalError("API Key is missing.")
        }
        self.apiKey = key
    }

    // MARK: - RevenueCat Configuration
    func configure() {
        let userId = Auth.auth().currentUser?.uid
        Purchases.configure(withAPIKey: apiKey, appUserID: userId)
        Purchases.logLevel = .debug
        Logger.log("RevenueCat configured with userId: \(userId ?? "Anonymous")", type: .info)
    }

    // MARK: - User Login
    func login(
        userId: String,
        completion: @escaping (Bool) -> Void
    ) {
        Purchases.shared.logIn(userId) { _, created, error in
            if let error = error {
                Logger.log("Error logging into RevenueCat: \(error.localizedDescription)", type: .error)
                completion(false)
                return
            }
            if created {
                Logger.log("New RevenueCat user created.", type: .info)
            } else {
                Logger.log("RevenueCat user successfully linked.", type: .info)
            }
            completion(true)
        }
    }

    // MARK: - User Logout
    func logout(completion: @escaping (Bool) -> Void) {
        Purchases.shared.logOut { _, error in
            if let error = error {
                Logger.log("Error logging out of RevenueCat: \(error.localizedDescription)", type: .error)
                completion(false)
                return
            }
            Logger.log("Successfully logged out from RevenueCat.", type: .info)
            completion(true)
        }
    }

    // MARK: - Premium Status
    func checkPremiumStatus(completion: @escaping (Bool) -> Void) {
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            if let error = error {
                Logger.log("Error fetching customer info: \(error.localizedDescription)", type: .error)
                completion(false)
                return
            }
            if let entitlement = customerInfo?.entitlements["Premium Access"], entitlement.isActive {
                Logger.log("User has Premium Access", type: .info)
                completion(true)
            } else {
                Logger.log("User does not have Premium Access", type: .info)
                completion(false)
            }
        }
    }

    // MARK: - Offerings and Packages
    func fetchPackages(completion: @escaping ([Package]?) -> Void) {
        Purchases.shared.getOfferings { offerings, error in
            if let error = error {
                Logger.log("Error fetching packages: \(error.localizedDescription)", type: .error)
                completion(nil)
                return
            }
            completion(offerings?.current?.availablePackages)
        }
    }

    // MARK: - Customer Info
    func refreshCustomerInfo(completion: @escaping (Bool) -> Void) {
        Purchases.shared.syncPurchases { customerInfo, error in
            if let error = error {
                Logger.log("Error refreshing customer info: \(error.localizedDescription)", type: .error)
                completion(false)
                return
            }
            let isPremium = customerInfo?.entitlements["premium"]?.isActive == true
            Logger.log("Customer info refreshed. Premium status: \(isPremium)", type: .info)
            completion(isPremium)
        }
    }

    func getCustomerInfo(completion: @escaping (CustomerInfo?) -> Void) {
        Purchases.shared.getCustomerInfo { customerInfo, error in
            if let error = error {
                Logger.log("Error fetching customer info: \(error.localizedDescription)", type: .error)
                completion(nil)
                return
            }
            let originalAppUserId = customerInfo?.originalAppUserId
            Logger.log("Original App User ID: \(originalAppUserId ?? "Unknown")", type: .info)
            let currentAppUserId = Purchases.shared.appUserID
            Logger.log("Current App User ID: \(currentAppUserId)", type: .info)
            completion(customerInfo)
        }
    }

    // MARK: - Purchase Handling
    func purchase(package: Package,
                  completion: @escaping (Bool) -> Void
    ) {
        Purchases.shared.purchase(package: package) { _, customerInfo, error, userCancelled in
            if let error = error {
                Logger.log("Purchase failed: \(error.localizedDescription)", type: .error)
                completion(false)
                return
            }
            if userCancelled {
                Logger.log("User cancelled purchase.", type: .info)
                completion(false)
                return
            }
            let isPremium = customerInfo?.entitlements["premium"]?.isActive == true
            Logger.log("Purchase successful. Premium status: \(isPremium)", type: .info)
            completion(isPremium)
        }
    }
}
