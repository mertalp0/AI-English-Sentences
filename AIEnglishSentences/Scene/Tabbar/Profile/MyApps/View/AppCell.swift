//
//  AppCell.swift
//  AIEnglishSentences
//
//  Created by mert alp on 10.01.2025.
//

import UIKit

struct AppModel {
    let appIcon: UIImage
    let appName: String
    let appDescription: String
}

protocol AppCellDelegate: AnyObject {
    func didTapOpen(_ app: AppModel)
}

final class AppCell: UITableViewCell {
    // MARK: - Properties
    weak var delegate: AppCellDelegate?
    private var app: AppModel?

    // MARK: - UI Elements
    private var containerView: UIView!
    private var appIconImageView: UIImageView!
    private var appNameLabel: UILabel!
    private var appDescriptionLabel: UILabel!
    private var openButton: UIButton!

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    func configure(with app: AppModel) {
        self.app = app
        appIconImageView.image = app.appIcon
        appNameLabel.text = app.appName
        appDescriptionLabel.text = app.appDescription
    }
}

// MARK: - UI Setup
private extension AppCell {
    private func setupUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        setupContainerView()
        setupAppIconImageView()
        setupAppNameLabel()
        setupOpenButton()
        setupAppDescriptionLabel()
        setupConstraints()
    }

    private func setupContainerView() {
        containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.mainColor?.cgColor
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        contentView.addSubview(containerView)
    }

    private func setupAppIconImageView() {
        appIconImageView = UIImageView()
        appIconImageView.layer.cornerRadius = 8
        appIconImageView.clipsToBounds = true
        appIconImageView.contentMode = .scaleAspectFill
        containerView.addSubview(appIconImageView)
    }

    private func setupAppNameLabel() {
        appNameLabel = UILabel()
        appNameLabel.font = .dynamicFont(size: 16, weight: .semibold)
        appNameLabel.textColor = .black
        containerView.addSubview(appNameLabel)
    }

    private func setupAppDescriptionLabel() {
        appDescriptionLabel = UILabel()
        appDescriptionLabel.font = .dynamicFont(size: 14, weight: .regular)
        appDescriptionLabel.textColor = .darkGray
        appDescriptionLabel.numberOfLines = 0
        containerView.addSubview(appDescriptionLabel)
    }

    private func setupOpenButton() {
        openButton = UIButton(type: .system)
        openButton.setTitle(.localized(for: .buttonOpenTitle), for: .normal)
        openButton.setTitleColor(.white, for: .normal)
        openButton.backgroundColor = .mainColor
        openButton.titleLabel?.font = .dynamicFont(size: 12, weight: .medium)
        openButton.layer.cornerRadius = 8
        openButton.addTarget(self, action: #selector(openButtonTapped), for: .touchUpInside)
        containerView.addSubview(openButton)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(UIHelper.dynamicHeight(8))
            make.leading.trailing.equalToSuperview().inset(16)
        }

        appIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIHelper.dynamicHeight(16))
            make.leading.equalToSuperview().inset(16)
            make.width.height.equalTo(UIHelper.dynamicHeight(60))
        }

        appNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(appIconImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(UIHelper.dynamicHeight(16))
        }

        openButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(appNameLabel)
            make.width.equalTo(UIHelper.dynamicWidth(50))
            make.height.equalTo(UIHelper.dynamicHeight(20))
        }

        appDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(appNameLabel)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(appNameLabel.snp.bottom).offset(UIHelper.dynamicHeight(8))
            make.bottom.equalToSuperview().inset(UIHelper.dynamicHeight(16))
        }
    }
}

// MARK: - Actions
private extension AppCell {
    @objc func openButtonTapped() {
        guard let app = app else { return }
        delegate?.didTapOpen(app)
    }
}
