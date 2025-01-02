import Foundation
import BaseMVVMCKit

final class ProfileViewModel: BaseViewModel {
    
    private let authService = AuthService.shared
    private let userService = UserService.shared
    private var appLauncher = AppLauncher.shared
    
    var user: UserModel? {
        didSet {
        }
    }
        
    func getUser(completion: @escaping (UserModel) -> Void) {
        userService.getUser(by: authService.getCurrentUserId()!) { result in
            switch result {
            case .success(let user):
                self.user = user
                completion(user)
            case .failure(let error):
                self.handleError(message: error.localizedDescription)
            }
        }
    }
    
    func logout(completion: @escaping (Bool) -> Void) {
        startLoading()
        authService.logout { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.stopLoading()
                switch result {
                case .success:
                    completion(true)
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
}
