//
//  ProfileCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import BaseMVVMCKit
import UIKit

final class ProfileCoordinator: BaseCoordinator {
    
    override func start() {
        
        let profileViewModel = ProfileViewModel()
        let profileVC = ProfileVC(viewModel: profileViewModel)
        profileVC.coordinator = self
        push(profileVC)
        
    }
    
    func showInfo() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate,
           let appCoordinator = sceneDelegate.appCoordinator {
            appCoordinator.start()
        }
    }
}

