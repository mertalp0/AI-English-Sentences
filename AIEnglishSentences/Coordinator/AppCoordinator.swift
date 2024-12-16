//
//  AppCoordinator.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import BaseMVVMCKit

final class AppCoordinator: BaseCoordinator{
    
    override func start() {
        let infoCoordinator = InfoCoordinator(navigationController: self.navigationController!)
        infoCoordinator.start()
    }
    
}
