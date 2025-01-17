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
    
    private init() {}

    /// RevenueCat'i başlatma
    func configure() {
        let userId = Auth.auth().currentUser?.uid
        Purchases.configure(withAPIKey: "appl_HdlrAmUjDppEqivJGGBMlREIZIv", appUserID: userId)
        print("RevenueCat configured with userId: \(userId ?? "Anonymous")")
    }

    /// Kullanıcı giriş yaptıktan sonra RevenueCat kullanıcı ID güncelleme
    func login(userId: String, completion: @escaping (Bool) -> Void) {
        Purchases.shared.logIn(userId) { customerInfo, created, error in
            if let error = error {
                print("Error logging into RevenueCat: \(error.localizedDescription)")
                completion(false)
                return
            }
            if created {
                print("New RevenueCat user created.")
            } else {
                print("RevenueCat user successfully linked.")
            }
            completion(true)
        }
    }

    /// Kullanıcı çıkış yaptıktan sonra RevenueCat kullanıcı ID sıfırla
    func logout(completion: @escaping (Bool) -> Void) {
        Purchases.shared.logOut { customerInfo, error in
            if let error = error {
                print("Error logging out of RevenueCat: \(error.localizedDescription)")
                completion(false)
                return
            }
            print("Successfully logged out from RevenueCat.")
            completion(true)
        }
    }

    /// Kullanıcının premium olup olmadığını kontrol et
    func checkPremiumStatus(completion: @escaping (Bool) -> Void) {
        Purchases.shared.getCustomerInfo { customerInfo, error in
            if let error = error {
                print("Error checking subscription status: \(error.localizedDescription)")
                completion(false)
                return
            }
            let isPremium = customerInfo?.entitlements["premium"]?.isActive == true
            print("Premium status: \(isPremium)")
            completion(isPremium)
        }
    }

    /// Abonelik Paketlerini Getir
    func fetchPackages(completion: @escaping ([Package]?) -> Void) {
        Purchases.shared.getOfferings { offerings, error in
            if let error = error {
                print("Error fetching packages: \(error.localizedDescription)")
                completion(nil)
                return
            }
            let availablePackages = offerings?.current?.availablePackages
            completion(availablePackages)
        }
    }

    /// Test Amaçlı Kullanıcıyı Premium Yap
//    func makeUserPremiumForTesting(completion: @escaping (Bool) -> Void) {
//        let testCustomerInfo = Purchases.shared.getCustomerInfo { customerInfo, error in
//            guard error == nil else {
//                print("Error fetching customer info: \(error!.localizedDescription)")
//                completion(false)
//                return
//            }
//            // Kullanıcıyı manuel olarak premium yap
//            let isPremium = true // Test amaçlı manuel premium durumu
//            print("User premium status overridden for testing: \(isPremium)")
//            completion(isPremium)
//        }
//    }
//
    
    /// Müşteri bilgilerini manuel olarak yenile
    func refreshCustomerInfo(completion: @escaping (Bool) -> Void) {
        Purchases.shared.syncPurchases { customerInfo, error in
            if let error = error {
                print("Error refreshing customer info: \(error.localizedDescription)")
                completion(false)
                return
            }
            let isPremium = customerInfo?.entitlements["premium"]?.isActive == true
            print("Customer info refreshed. Premium status: \(isPremium)")
            completion(isPremium)
        }
    }
    
    /// Abonelik Satın Alma İşlemi
    func purchase(package: Package, completion: @escaping (Bool) -> Void) {
        Purchases.shared.purchase(package: package) { transaction, customerInfo, error, userCancelled in
            if let error = error {
                print("Purchase failed: \(error.localizedDescription)")
                completion(false)
                return
            }
            if userCancelled {
                print("User cancelled purchase.")
                completion(false)
                return
            }
            let isPremium = customerInfo?.entitlements["premium"]?.isActive == true
            print("Purchase successful. Premium status: \(isPremium)")
            
            completion(isPremium)
        }
    }

    /// Kullanıcı bilgilerini getirme
    func getCustomerInfo(completion: @escaping (CustomerInfo?) -> Void) {
        Purchases.shared.getCustomerInfo { customerInfo, error in
            if let error = error {
                print("Error fetching customer info: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // Orijinal kullanıcı ID'si
            let originalAppUserId = customerInfo?.originalAppUserId
            print("Original App User ID: \(originalAppUserId ?? "Unknown")")

            // Mevcut kullanıcı ID'si
            let currentAppUserId = Purchases.shared.appUserID
            print("Current App User ID: \(currentAppUserId)")
            
            completion(customerInfo)
        }
    }
    
}
