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

extension AppBarDelegate {
    func rightButtonTapped() {}
}

final class AppBar: UIView {
    // MARK: - Properties
    weak var delegate: AppBarDelegate?

    // MARK: - UI Elements
    private var titleLabel: UILabel!
    private var leftButton: UIButton!
    private var rightButton: UIButton!

    // MARK: - Initialization
    init(type: AppBarType) {
        super.init(frame: .zero)
        setupUI()
        configure(with: type)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        delegate?.leftButtonTapped()
    }

    @objc private func rightButtonTapped() {
        delegate?.rightButtonTapped()
    }
}

// MARK: - Setup UI
private extension AppBar {
    private func setupUI() {
        setupTitleLabel()
        setupLeftButton()
        setupRightButton()
        setupConstraints()
    }

    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = .dynamicFont(size: 24, weight: .bold)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
    }

    private func setupLeftButton() {
        leftButton = UIButton()
        leftButton.tintColor = .main
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        leftButton.addPressAnimation()
        addSubview(leftButton)
    }

    private func setupRightButton() {
        rightButton = UIButton()
        rightButton.tintColor = .main
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        rightButton.addPressAnimation()
        addSubview(rightButton)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        snp.makeConstraints { make in
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
            return LocalizationManager.shared.localized(for: .appBarHistory)
        case .profile:
            return LocalizationManager.shared.localized(for: .appBarProfile)
        case .contexta:
            return LocalizationManager.shared.localized(for: .appBarContexta)
        case .result:
            return LocalizationManager.shared.localized(for: .appBarResult)
        case .privacyPolicy:
            return LocalizationManager.shared.localized(for: .appBarPrivacyPolicy)
        case .myApps:
            return LocalizationManager.shared.localized(for: .appBarMyApps)
        case .languages:
            return LocalizationManager.shared.localized(for: .appBarLanguages)
        }
    }

    var rightIcon: UIImage? {
        return nil
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
        case .profile:
            return .white
        default:
            return .main
        }
    }
}
