//
//  AuthBar.swift
//  AIEnglishSentences
//
//  Created by mert alp on 4.01.2025.
//

import UIKit
import SnapKit

protocol AuthBarDelegate: AnyObject {
    func didTapBackButton()
}

final class AuthBar: UIView {

    // MARK: - Delegate
    weak var delegate: AuthBarDelegate?

    // MARK: - UI Elements
    private var backButton: UIButton!
    private var titleLabel: UILabel!

    // MARK: - Initialization
    init(title: String) {
        super.init(frame: .zero)
        setupUI(with: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions
    @objc private func didTapBackButton() {
        delegate?.didTapBackButton()
    }
}

// MARK: - UI Setup
private extension AuthBar {

    private func setupUI(with title: String) {
        setupBackButton()
        setupTitleLabel(with: title)
    }

    private func setupBackButton() {
        backButton = UIButton(type: .system)
        let backIcon = UIImage.appIcon(.chevronLeft)?.resizedIcon(dynamicSize: 18, weight: .semibold)
        backButton.setImage(backIcon, for: .normal)
        backButton.tintColor = .mainColor
        backButton.backgroundColor = UIColor.mainColor?.withAlphaComponent(0.08)
        backButton.layer.cornerRadius = 18
        backButton.clipsToBounds = true
        backButton.contentHorizontalAlignment = .center
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        addSubview(backButton)

        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(UIHelper.dynamicHeight(36))
        }
    }

    private func setupTitleLabel(with title: String) {
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .dynamicFont(size: 20, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.greaterThanOrEqualTo(backButton.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-56)
            make.centerX.equalToSuperview()
        }
    }
}
