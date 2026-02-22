//
//  RemoteConfigManager.swift
//  AIEnglishSentences
//

import FirebaseRemoteConfig
import Foundation

final class RemoteConfigManager {
    static let shared = RemoteConfigManager()
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    private init() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 3600 // 1 hour
        remoteConfig.configSettings = settings
        
        // Set default values
        let defaultValues: [String: NSObject] = [
            "sentence_limit": 50 as NSObject
        ]
        remoteConfig.setDefaults(defaultValues)
    }
    
    func fetchRemoteConfig(completion: @escaping () -> Void) {
        remoteConfig.fetchAndActivate { status, error in
            if let error = error {
                print("Remote Config fetch error: \(error.localizedDescription)")
            }
            completion()
        }
    }
    
    var sentenceLimit: Int {
        return Int(remoteConfig.configValue(forKey: "sentence_limit").numberValue.intValue)
    }
}
