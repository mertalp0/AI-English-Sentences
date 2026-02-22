//
//  AuthButton.swift
//  AIEnglishSentences
//
//  Created by mert alp on 3.01.2025.
//

import UIKit
import SnapKit

protocol AuthButtonDelegate: AnyObject {
    func didTapButton(type: AuthButtonType)
}

final class AuthButton: UIButton {
    // MARK: - Properties
    private let authButtonType: AuthButtonType
    weak var delegate: AuthButtonDelegate?

    // MARK: - Initialization
    init(type: AuthButtonType) {
        self.authButtonType = type
        super.init(frame: .zero)
        setupUI()
        configure(with: type)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI
private extension AuthButton {
    func setupUI() {
        setupButtonStyle()
        setupActions()
    }

    func setupButtonStyle() {
        self.titleLabel?.font = .dynamicFont(size: 16, weight: .semibold)
        self.layer.cornerRadius = 14
        self.clipsToBounds = false
    }

    func setupActions() {
        self.addTarget(self, action: #selector(animateDown), for: .touchDown)
        self.addTarget(self, action: #selector(buttonTapped), for: [.touchUpInside, .touchCancel, .touchDragExit])
    }
}

// MARK: - Configuration
private extension AuthButton {
    func configure(with type: AuthButtonType) {
        self.setTitle(type.title, for: .normal)

        switch type {
        case .normal:
            configureAsNormalButton()
        case .google, .apple:
            configureAsSocialButton(with: type.image)
        }
    }

    func configureAsNormalButton() {
        self.backgroundColor = .mainColor
        self.setTitleColor(.white, for: .normal)
        self.layer.shadowColor = UIColor.mainColor?.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.3
    }

    func configureAsSocialButton(with image: UIImage?) {
        self.backgroundColor = .systemBackground
        self.setTitleColor(.label, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 0.06

        if let icon = image {
            self.setImage(icon, for: .normal)
            self.imageView?.contentMode = .scaleAspectFit
            self.tintColor = .white
            self.semanticContentAttribute = .forceLeftToRight
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        }
    }
}

// MARK: - Actions
private extension AuthButton {
    @objc func buttonTapped() {
        self.animateScaleUp()
        delegate?.didTapButton(type: authButtonType)
    }

    @objc func animateDown() {
        self.animateScaleDown()
    }
}

// MARK: - AuthButtonType Enum
enum AuthButtonType {
    case normal(title: NormalButtonTitle)
    case google
    case apple

    var title: String {
        switch self {
        case .normal(let title): return title.title
        case .google: return .localized(for: .googleButtonTitle)
        case .apple: return .localized(for: .appleButtonTitle)
        }
    }

    var image: UIImage? {
        switch self {
        case .google: return .appImage(.google)
        case .apple: return .appImage(.apple)
        case .normal: return nil
        }
    }
}

// MARK: - NormalButtonTitle Enum
enum NormalButtonTitle {
    case login
    case signup

    var title: String {
        switch self {
        case .login: return .localized(for: .login)
        case .signup: return .localized(for: .signup)
        }
    }
}
