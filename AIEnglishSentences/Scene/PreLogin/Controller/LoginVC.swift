//
//  LoginVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import UIKit
import BaseMVVMCKit

final class LoginVC: BaseViewController<LoginCoordinator, LoginViewModel>{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    //MARK: - Deinit
    deinit {
        print("\(self) deallocated")
    }
}
