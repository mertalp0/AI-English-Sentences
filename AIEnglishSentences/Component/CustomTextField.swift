//
//  CustomTextField.swift
//  AIEnglishSentences
//
//  Created by mert alp on 20.12.2024.
//

import UIKit

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
    private let textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.textColor = .black
        tf.backgroundColor = .clear
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let togglePasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(systemName: "eye.slash")
        button.setImage(image, for: .normal)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(containerView)
        containerView.layer.addSublayer(shadowLayer)
        containerView.addSubview(textField)
        
        validationLabel = UILabel()
        validationLabel.textColor = .red
        validationLabel.font = UIFont.systemFont(ofSize: 12)
        validationLabel.numberOfLines = 0
        validationLabel.isHidden = true
        validationLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(validationLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            
            validationLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 4),
            validationLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            validationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            validationLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Delegate for focus handling
        textField.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowLayer.frame = containerView.bounds
    }
    
    // MARK: - Public Configuration
    func configure(placeholder: String, type: CustomTextFieldType) {
           self.placeholder = placeholder
           self.type = type
           
           if type == .password {
               textField.isSecureTextEntry = true
               addPasswordToggle()
           }
       }
    
    private func addPasswordToggle() {
        containerView.addSubview(togglePasswordButton)
        NSLayoutConstraint.activate([
            togglePasswordButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            togglePasswordButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            togglePasswordButton.widthAnchor.constraint(equalToConstant: 24),
            togglePasswordButton.heightAnchor.constraint(equalToConstant: 24),
            
            textField.trailingAnchor.constraint(equalTo: togglePasswordButton.leadingAnchor, constant: -8)
        ])
        
        togglePasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
    }
    
    @objc private func togglePasswordVisibility() {
        isPasswordVisible.toggle()
        textField.isSecureTextEntry = !isPasswordVisible
        let image = isPasswordVisible ? UIImage(systemName: "eye") : UIImage(systemName: "eye.slash")
        togglePasswordButton.setImage(image, for: .normal)
    }
    
    // MARK: - Focus State Handling
    private func updateFocusState(isFocused: Bool) {
        UIView.animate(withDuration: 0.3) {
            if isFocused {
                self.containerView.layer.borderColor = UIColor.systemBlue.cgColor
                self.shadowLayer.shadowOpacity = 0.3
            } else {
                self.containerView.layer.borderColor = UIColor.lightGray.cgColor
                self.shadowLayer.shadowOpacity = 0.1
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
