//
//  PopupViewController.swift
//  AIEnglishSentences
//
//  Created by mert alp on 3.01.2025.
//

import UIKit

protocol PopupViewControllerDelegate: AnyObject {
    func popupDidCancel(popupType: PopupType)
    func popupDidConfirm(popupType: PopupType)
}

enum PopupType {
    case logout
    case delete
    case custom(title: String, message: String)
}

final class PopupViewController: UIViewController {

    // MARK: - Properties
    weak var delegate: PopupViewControllerDelegate?
    var popupType: PopupType
    var iconImage: UIImage?
    var cancelButtonText: String?
    var confirmButtonText: String?

    // MARK: - UI Elements
    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let cancelButton = UIButton()
    private let confirmButton = UIButton()

    // MARK: - Initializer
    init(popupType: PopupType, icon: UIImage?, cancelText: String?, confirmText: String?) {
        self.popupType = popupType
        super.init(nibName: nil, bundle: nil)
        self.iconImage = icon
        self.cancelButtonText = cancelText
        self.confirmButtonText = confirmText
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        if let iconImage = iconImage {
            iconImageView.image = iconImage
            iconImageView.tintColor = .mainColor
            containerView.addSubview(iconImageView)

            iconImageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(UIHelper.dynamicHeight(20))
                make.centerX.equalToSuperview()
                make.width.height.equalTo(UIHelper.dynamicHeight(40))
            }
        }

        // Title and Message Labels
        switch popupType {
        case .logout:
            configureLabels(title: "Logout?", message: "Are you sure you want to log out?")
        case .delete:
            configureLabels(title: "Delete?", message: "Are you sure you want to delete this item?")
        case .custom(let title, let message):
            configureLabels(title: title, message: message)
        }

        // Cancel Button
        cancelButton.setTitle(cancelButtonText, for: .normal)
        cancelButton.setTitleColor(.darkGray, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        cancelButton.addTarget(self, action: #selector(onCancelTapped), for: .touchUpInside)
        containerView.addSubview(cancelButton)

        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(UIHelper.dynamicHeight(20))
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(UIHelper.dynamicHeight(44))
            make.bottom.equalToSuperview().offset(-UIHelper.dynamicHeight(16))
        }

        // Confirm Button
        confirmButton.setTitle(confirmButtonText, for: .normal)
        confirmButton.setTitleColor(.systemRed, for: .normal)
        confirmButton.titleLabel?.font = .dynamicFont(size: 16, weight: .medium)
        confirmButton.addTarget(self, action: #selector(onConfirmTapped), for: .touchUpInside)
        containerView.addSubview(confirmButton)

        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.top)
            make.leading.equalTo(cancelButton.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(cancelButton.snp.height)
            make.width.equalTo(cancelButton.snp.width)
        }
    }

    private func configureLabels(title: String, message: String) {
        // Title Label
        titleLabel.text = title
        titleLabel.font = .dynamicFont(size: 18, weight: .semibold)
        titleLabel.textColor = .mainColor
        titleLabel.textAlignment = .center
        containerView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(UIHelper.dynamicHeight(10))
            make.leading.trailing.equalToSuperview().inset(16)
        }

        // Message Label
        messageLabel.text = message
        messageLabel.font = .dynamicFont(size: 14, weight: .regular)
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        containerView.addSubview(messageLabel)

        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIHelper.dynamicHeight(8))
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: - Actions
    @objc private func onCancelTapped() {
        self.delegate?.popupDidCancel(popupType: popupType)
    }

    @objc private func onConfirmTapped() {
        dismiss(animated: true) {
            self.delegate?.popupDidConfirm(popupType: self.popupType)
        }
       
    }
}
