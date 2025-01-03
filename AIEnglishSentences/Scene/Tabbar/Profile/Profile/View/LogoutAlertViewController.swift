//
//  LogoutAlertViewController.swift
//  AIEnglishSentences
//
//  Created by mert alp on 3.01.2025.
//

import UIKit

final class LogoutAlertViewController: UIViewController {

    // MARK: - Properties
    var onCancel: (() -> Void)?
    var onLogout: (() -> Void)?

    // MARK: - UI Elements
    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let cancelButton = UIButton()
    private let logoutButton = UIButton()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        // Container View
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true
        view.addSubview(containerView)

        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }

        // Icon Image View
        iconImageView.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        iconImageView.tintColor = .systemBlue
        containerView.addSubview(iconImageView)

        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(40)
        }

        // Title Label
        titleLabel.text = "Logout?"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        containerView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        // Message Label
        messageLabel.text = "Are you sure you want to log out? You'll need to log in again to access your account."
        messageLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        containerView.addSubview(messageLabel)

        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        // Cancel Button
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.darkGray, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        cancelButton.addTarget(self, action: #selector(onCancelTapped), for: .touchUpInside)
        containerView.addSubview(cancelButton)

        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-16)
        }

        // Logout Button
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.systemRed, for: .normal)
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        logoutButton.addTarget(self, action: #selector(onLogoutTapped), for: .touchUpInside)
        containerView.addSubview(logoutButton)

        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.top)
            make.leading.equalTo(cancelButton.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(cancelButton.snp.height)
            make.width.equalTo(cancelButton.snp.width)
        }
    }

    // MARK: - Actions
    @objc private func onCancelTapped() {
        dismiss(animated: true, completion: onCancel)
    }

    @objc private func onLogoutTapped() {
        dismiss(animated: true, completion: onLogout)
    }
}
