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

enum AppBarType {
    case generate
    
    var title: String {
        switch self {
        case .generate:
            return "Generate"
        }
    }
    
    var rightIcon: UIImage? {
        switch self {
        case .generate:
            return UIImage(systemName: "plus")
        }
    }
    
    var leftIcon: UIImage? {
        switch self {
        case .generate:
            return UIImage(systemName: "chevron.left")
        }
    }
}

final class AppBar: UIView {
    
    // MARK: - Properties
    weak var delegate: AppBarDelegate?
    
    //MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
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
        backgroundColor = .init(hex: "F2F2F2")
        
        addSubview(titleLabel)
        addSubview(leftButton)
        addSubview(rightButton)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        leftButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(50)
        }
        
        rightButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(50)
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
            let resizedLeftIcon = leftIcon.withConfiguration(UIImage.SymbolConfiguration(pointSize: 22, weight: .bold))
            leftButton.setImage(resizedLeftIcon, for: .normal)
        }

        if let rightIcon = type.rightIcon {
            let resizedRightIcon = rightIcon.withConfiguration(UIImage.SymbolConfiguration(pointSize: 22, weight: .bold))
            rightButton.setImage(resizedRightIcon, for: .normal)
        }
        
        leftButton.isHidden = (type.leftIcon == nil)
        rightButton.isHidden = (type.rightIcon == nil)
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
