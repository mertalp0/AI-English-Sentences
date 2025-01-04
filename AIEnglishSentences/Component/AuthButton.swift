//
//  AuthButton.swift
//  AIEnglishSentences
//
//  Created by mert alp on 3.01.2025.
//


import UIKit
import SnapKit


enum AuthButtonType {
    case normal(title: NormalButtonTitle)
    case google
    case apple
    
    var title: String {
        switch self {
        case .normal(let title): return title.rawValue
        case .google: return "Continue with Google"
        case .apple: return "Continue with Apple"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .google: return UIImage(named: "google_icon")
        case .apple: return UIImage(systemName: "applelogo")
        case .normal: return nil
        }
    }
}

enum NormalButtonTitle: String {
    case login = "Login"
    case signup = "Sign up"
}

protocol AuthButtonDelegate: AnyObject {
    func didTapButton(type: AuthButtonType)
}

final class AuthButton: UIButton {
    
    private let authButtonType: AuthButtonType
    weak var delegate: AuthButtonDelegate?
    
    init(type: AuthButtonType) {
        self.authButtonType = type
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.setTitle(authButtonType.title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.layer.cornerRadius = 8
        
        switch authButtonType {
        case .normal:
            self.backgroundColor = .init(hex: "1F41BB")
            self.setTitleColor(.white, for: .normal)
        case .google, .apple:
            self.backgroundColor = .white
            self.setTitleColor(.black, for: .normal)
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.systemGray4.cgColor
            
            if let icon = authButtonType.image {
                self.setImage(icon, for: .normal)
                self.imageView?.contentMode = .scaleAspectFit
                self.tintColor = .white
                self.semanticContentAttribute = .forceLeftToRight
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
            }
        }
        
        self.addTarget(self, action: #selector(animateDown), for: .touchDown)
        self.addTarget(self, action: #selector(buttonTapped), for: [.touchUpInside, .touchCancel, .touchDragExit])
    }
    
    @objc private func buttonTapped() {
        self.animateScaleUp()
        delegate?.didTapButton(type: authButtonType)
    }
    
    // MARK: - Animation Methods
    @objc private func animateDown() {
        self.animateScaleDown()

    }
}

