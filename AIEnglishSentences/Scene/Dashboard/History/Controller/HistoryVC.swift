//
//  HistoryVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 16.12.2024.
//

import UIKit
import BaseMVVMCKit

final class HistoryVC: BaseViewController<HistoryCoordinator, HistoryViewModel>{
    
    //MARK: - UI Elements
    private var  pageTitle : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupUI()
    }
    
    private func setupUI(){
        view.backgroundColor = .white
        
        //Page Title
        pageTitle = UILabel()
        pageTitle.text = String(describing: type(of: self))
        pageTitle.textColor = .black
        
        view.addSubview(pageTitle)
        pageTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
