//
//  CustomTextField.swift
//  AIEnglishSentences
//
//  Created by mert alp on 20.12.2024.
//

import UIKit
import SnapKit

final class CustomTextField: UIView {

    // MARK: - Properties
    private var isPasswordVisible = false
    private var type: CustomTextFieldType = .normal
    private var validationLabel: UILabel!

    private var titleLabel: UILabel!
    private var textField: UITextField!
    private var containerView: UIView!
    private var togglePasswordButton: UIButton!
    private let shadowLayer: CALayer = CALayer()

    var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }

    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        shadowLayer.frame = containerView.bounds
    }

    // MARK: - Configuration
    func configure(placeholder: String, type: CustomTextFieldType, title: String?) {
        self.type = type
        titleLabel.text = title
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.dynamicFont(size: 16)
            ]
        )

        if type == .password {
            textField.isSecureTextEntry = true
            setupTogglePasswordButton()
        }
    }

    private func setupTogglePasswordButton() {
        togglePasswordButton = UIButton(type: .custom)
        let image = UIImage.appIcon(.eyeSlash)
        togglePasswordButton.setImage(image, for: .normal)
        togglePasswordButton.tintColor = .gray
        containerView.addSubview(togglePasswordButton)

        togglePasswordButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(12)
            make.width.height.equalTo(24)
        }

        textField.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview().inset(UIHelper.dynamicHeight(10))
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(togglePasswordButton.snp.leading).offset(-8)
        }

        togglePasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
    }

    @objc private func togglePasswordVisibility() {
        isPasswordVisible.toggle()
        textField.isSecureTextEntry = !isPasswordVisible
        let image = isPasswordVisible ? UIImage.appIcon(.eye) : UIImage.appIcon(.eyeSlash)
        togglePasswordButton.setImage(image, for: .normal)
    }

    // MARK: - Focus Animations
    private func updateFocusState(isFocused: Bool) {
        UIView.animate(withDuration: 0.25) {
            self.containerView.layer.borderColor = isFocused
                ? UIColor.mainColor?.cgColor
                : UIColor.systemGray5.cgColor
            self.containerView.layer.borderWidth = isFocused ? 2 : 1.5
            self.containerView.backgroundColor = isFocused ? .systemBackground : UIColor.systemGray6
        }
    }

    // MARK: - Validation
    func validate(with errorMessage: String? = nil) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            containerView.layer.borderColor = UIColor.red.cgColor
            validationLabel.text = errorMessage ?? .localized(for: .validationRequiredField)
            validationLabel.isHidden = false
            return false
        }
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        validationLabel.isHidden = true
        return true
    }
}

// MARK: - Setup UI
private extension CustomTextField {
    private func setupUI() {
        setupTitleLabel()
        setupContainerView()
        setupTextField()
        setupValidationLabel()
        setupConstraints()
    }

    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textColor = .secondaryLabel
        titleLabel.font = .dynamicFont(size: 13, weight: .semibold)
        titleLabel.textAlignment = .left
        addSubview(titleLabel)
    }

    private func setupContainerView() {
        containerView = UIView()
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 1.5
        containerView.layer.borderColor = UIColor.systemGray5.cgColor
        containerView.backgroundColor = UIColor.systemGray6
        addSubview(containerView)
    }

    private func setupTextField() {
        textField = UITextField()
        textField.borderStyle = .none
        textField.textColor = .label
        textField.backgroundColor = .clear
        textField.font = .dynamicFont(size: 16)
        textField.delegate = self
        containerView.addSubview(textField)
    }

    private func setupValidationLabel() {
        validationLabel = UILabel()
        validationLabel.textColor = .red
        validationLabel.font = .dynamicFont(size: 10)
        validationLabel.numberOfLines = 0
        validationLabel.isHidden = true
        addSubview(validationLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIHelper.dynamicHeight(20))
        }

        containerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIHelper.dynamicHeight(50))
        }

        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(UIHelper.dynamicHeight(10))
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }

        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}

// MARK: - UITextFieldDelegate
extension CustomTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateFocusState(isFocused: true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateFocusState(isFocused: false)
    }
}

enum CustomTextFieldType {
    case normal
    case password
}
