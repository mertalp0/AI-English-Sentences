import Foundation
import BaseMVVMCKit
import StoreKit

final class ProfileViewModel: BaseViewModel {
    
    private let authService : AuthService = AuthServiceImpl.shared
    private let userService = UserService.shared
    private var appLauncher = AppLauncher.shared
    private let subscriptionService = SubscriptionService.shared
    
    
    var user: UserModel? {
        didSet {}
    }
    
    func getUser(completion: @escaping (UserModel) -> Void) {
        
        guard let userId = authService.getCurrentUserId() else {
            return
        }
        
        userService.getUser(by: userId) { result in
            switch result {
            case .success(let user):
                self.user = user
                completion(user)
            case .failure(let error):
                self.handleError(message: error.localizedDescription)
            }
        }
    }
    
    func updateUser(name: String, completion: @escaping (Bool) -> Void) {
        guard let userId = authService.getCurrentUserId() else {
            completion(false)
            return
        }
        
        userService.updateUser(by: userId, name: name) { result in
            switch result {
            case .success:
                self.user?.name = name
                completion(true)
            case .failure(let error):
                self.handleError(message: error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func logout(completion: @escaping (Bool) -> Void) {
        startLoading()
        authService.logout { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.stopLoading()
                switch result {
                case .success(_):
                    completion(true)
                case .failure(let error):
                    self.handleError(message: error.localizedDescription)
                    completion(false)
                }
            }
        }
    }
    
    func deleteAccount(completion: @escaping (Bool) -> Void) {
        startLoading()
        authService.deleteAccount { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.stopLoading()
                switch result {
                case .success(_):
                    completion(true)
//                        self.userService.deleteUserData(by: userId) { userDataResult in
//                            switch userDataResult {
//                            case .success:
//                                self.stopLoading()
//                                completion(true)
//                            case .failure(let error):
//                                self.handleError(message: error.localizedDescription)
//                                completion(false)
//                            }
//                        }
                    
                case .failure(let error):
                    self.handleError(message: error.localizedDescription)
                    completion(false)
                }
            }
        }
    }
    
    func openIqTestApp(completion: @escaping (Bool) -> Void) {
        let appURLScheme = AppConstants.URLs.iqTestAppURLScheme
        let appStoreURL = AppConstants.URLs.iqTestAppStoreURL
        
        appLauncher.openApp(appURLScheme: appURLScheme, appStoreURL: appStoreURL, completion: completion)
    }
    
    @available(iOS 14.0, *)
    func rateAppInAppStore() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}
