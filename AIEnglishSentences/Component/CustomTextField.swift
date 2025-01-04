//
//  CustomTextField.swift
//  AIEnglishSentences
//
//  Created by mert alp on 20.12.2024.
//

import UIKit
import SnapKit

enum CustomTextFieldType {
    case normal
    case password
}

final class CustomTextField: UIView {
    
    // MARK: - Properties
    private var isPasswordVisible = false
    private var type: CustomTextFieldType = .normal
    private var validationLabel: UILabel!
    
    // MARK: - Subviews
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let textField: UITextField = {
            let tf = UITextField()
            tf.borderStyle = .none
            tf.textColor = .black
            tf.backgroundColor = .clear
            tf.font = UIFont.systemFont(ofSize: 16)
            return tf
        }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    private let togglePasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(systemName: "eye.slash")
        button.setImage(image, for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    private let shadowLayer: CALayer = {
        let layer = CALayer()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        return layer
    }()
    
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
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(containerView)
        containerView.layer.addSublayer(shadowLayer)
        containerView.addSubview(textField)
        
        validationLabel = UILabel()
        validationLabel.textColor = .red
        validationLabel.font = UIFont.systemFont(ofSize: 10)
        validationLabel.numberOfLines = 0
        validationLabel.isHidden = true
        addSubview(validationLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        textField.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowLayer.frame = containerView.bounds
    }
    
    // MARK: - Public Configuration
      func configure(placeholder: String, type: CustomTextFieldType, title: String?) {
          self.type = type
          titleLabel.text = title
          textField.attributedPlaceholder = NSAttributedString(
              string: placeholder,
              attributes: [
                  .foregroundColor: UIColor.lightGray,
                  .font: UIFont.systemFont(ofSize: 16)
              ]
          )
          
          if type == .password {
              textField.isSecureTextEntry = true
              addPasswordToggle()
          }
      }
    
    private func addPasswordToggle() {
        containerView.addSubview(togglePasswordButton)
        togglePasswordButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(12)
            make.width.height.equalTo(24)
        }
        
        textField.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(togglePasswordButton.snp.leading).offset(-8)
        }
        
        togglePasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
    }
    
    @objc private func togglePasswordVisibility() {
        isPasswordVisible.toggle()
        textField.isSecureTextEntry = !isPasswordVisible
        let image = isPasswordVisible ? UIImage(systemName: "eye") : UIImage(systemName: "eye.slash")
        togglePasswordButton.setImage(image, for: .normal)
    }
    
    // MARK: - Focus Animasyon
    private func updateFocusState(isFocused: Bool) {
        UIView.animate(withDuration: 0.3) {
            if isFocused {
                self.containerView.layer.borderColor = UIColor.mainColor?.cgColor
                self.containerView.layer.borderWidth = 1.5
                self.shadowLayer.shadowOpacity = 0.4
                self.shadowLayer.shadowRadius = 8
            } else {
                self.containerView.layer.borderColor = UIColor.lightGray.cgColor
                self.shadowLayer.shadowOpacity = 0.1
                self.shadowLayer.shadowRadius = 4
            }
        }
    }
    
    // MARK: - Validation
    func validate(with errorMessage: String? = nil) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            containerView.layer.borderColor = UIColor.red.cgColor
            validationLabel.text = errorMessage ?? "This field is required."
            validationLabel.isHidden = false
            return false
        }
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        validationLabel.isHidden = true
        return true
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
