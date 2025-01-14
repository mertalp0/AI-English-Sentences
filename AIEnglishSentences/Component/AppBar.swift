//
//  AppBar.swift
//  AIEnglishSentences
//
//  Created by mert alp on 27.12.2024.
//

import UIKit
import SnapKit

protocol AppBarDelegate: AnyObject {
    func leftButtonTapped()
    func rightButtonTapped()
}

final class AppBar: UIView {
    
    // MARK: - Properties
    weak var delegate: AppBarDelegate?
    
    //MARK: - UI Elements
     var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .dynamicFont(size: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton()
        button.tintColor = .main
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        button.tintColor = .main
        return button
    }()
    
    // MARK: - Initialization
    init(type: AppBarType) {
        super.init(frame: .zero)
        setupView()
        configure(with: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = .clear
        
        addSubview(titleLabel)
        addSubview(leftButton)
        addSubview(rightButton)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(UIHelper.dynamicHeight(60))
        }
        
        leftButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(UIHelper.dynamicHeight(50))
        }
        
        rightButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(UIHelper.dynamicHeight(50))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        leftButton.addPressAnimation()
        rightButton.addPressAnimation()
        
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Configuration
    private func configure(with type: AppBarType) {
        titleLabel.text = type.title

        if let leftIcon = type.leftIcon {
            let resizedLeftIcon = leftIcon.resizedIcon(dynamicSize: 22, weight: .bold)
            leftButton.setImage(resizedLeftIcon, for: .normal)
        }

        if let rightIcon = type.rightIcon {
            let resizedRightIcon = rightIcon.resizedIcon(dynamicSize: 22, weight: .bold)
            rightButton.setImage(resizedRightIcon, for: .normal)
        }
        
        titleLabel.textColor = type.titleColor
        
        rightButton.setTitleColor(type.titleColor, for: .normal)
        leftButton.setTitleColor(type.titleColor, for: .normal)

        leftButton.isHidden = type.leftIcon == nil
        rightButton.isHidden = type.rightIcon == nil
    }
    
    // MARK: - Actions
    @objc private func leftButtonTapped() {
        print("Left button tapped in AppBar")
        delegate?.leftButtonTapped()
    }

    @objc private func rightButtonTapped() {
        print("Right button tapped in AppBar")
        delegate?.rightButtonTapped()
    }
}


enum AppBarType {
    case generate(pageCellType: CellType)
    case history
    case profile
    case contexta
    case result
    case privacyPolicy
    case myApps
    case languages
    
    var title: String {
        switch self {
        case .generate(let pageCellType):
            return pageCellType.title
        case .history:
            return "History"
        case .profile:
            return "My Profile"
        case .contexta:
            return "Contexta"
        case .result:
            return "Sentences"
        case .privacyPolicy:
            return "Privacy Policy"
        case .myApps:
            return "My Apps"
        case .languages:
            return "Languages"
        }

    }
    
    var rightIcon: UIImage? {
        switch self {
        case .generate:
            return nil
        case .history:
            return nil
        case .profile:
            return nil
        case .contexta:
            return nil
        case .result:
            return nil
        case .privacyPolicy:
            return nil
        case .myApps:
            return nil
        case .languages:
            return nil
        }
    }
    
    var leftIcon: UIImage? {
        switch self {
        case .generate:
            return .appIcon(.chevronLeft)
        case .history:
            return nil
        case .profile:
            return nil
        case .contexta:
            return nil
        case .result:
            return .appIcon(.chevronLeft)
        case .privacyPolicy:
            return .appIcon(.chevronLeft)
        case .myApps:
            return .appIcon(.chevronLeft)
        case .languages:
            return .appIcon(.chevronLeft)
        }
        
    }
    
    var titleColor: UIColor {
        switch self {
        case .generate:
            return .main
        case .history:
            return .main
        case .profile:
            return .white
        case .contexta:
            return .main
        case .result:
            return .main
        case .privacyPolicy:
            return .main
        case .myApps:
            return .main
        case .languages:
            return .main
        }
    }
}

