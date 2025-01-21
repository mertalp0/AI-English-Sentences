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
        let backIcon = UIImage.appIcon(.chevronLeft)?.resizedIcon(dynamicSize: 22, weight: .bold)
        backButton.setImage(backIcon, for: .normal)
        backButton.tintColor = .mainColor
        backButton.contentHorizontalAlignment = .leading
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        addSubview(backButton)

        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(UIHelper.dynamicHeight(24))
        }
    }

    private func setupTitleLabel(with title: String) {
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .dynamicFont(size: 27, weight: .bold)
        titleLabel.textColor = .mainColor
        titleLabel.textAlignment = .center
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.greaterThanOrEqualTo(backButton.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
