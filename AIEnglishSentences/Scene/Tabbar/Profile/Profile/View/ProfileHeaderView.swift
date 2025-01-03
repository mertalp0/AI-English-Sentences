//
//  ProfileHeaderView.swift
//  AIEnglishSentences
//
//  Created by mert alp on 02.01.2025.
//

import UIKit
import SnapKit

protocol ProfileHeaderViewDelegate: AnyObject {
    func didUpdateName(_ newName: String)
}
final class ProfileHeaderView: UIView {
    
    // MARK: - UI Elements
    private var appBar: AppBar!
    private var avatarImageView: UIImageView!
    private var nameLabel: UILabel!
    private var nameTextField: UITextField!
    private var emailLabel: UILabel!
    private var editButton: UIButton!
    
    weak var delegate: ProfileHeaderViewDelegate?
    
    // MARK: - Properties
    private var isEditingName = false {
        didSet {
            updateEditingState()
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        
        // AppBar
        appBar = AppBar(type: .profile)
        self.addSubview(appBar)
        
        appBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + 10)
        }
        
        // Avatar
        avatarImageView = UIImageView()
        avatarImageView.image = UIImage(systemName: "person.circle.fill")
        avatarImageView.tintColor = .white
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = 40
        avatarImageView.clipsToBounds = true
        self.addSubview(avatarImageView)
        
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(appBar.snp.bottom).offset(16)
            make.width.height.equalTo(80)
        }
        
        // Name Label
        nameLabel = UILabel()
        nameLabel.text = "Loading..."
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        nameLabel.isHidden = false
        self.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.top).offset(8)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-60) // Edit butonundan önce bitiyor
        }
        
        // Name TextField
        nameTextField = UITextField()
        nameTextField.textColor = .black
        nameTextField.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        nameTextField.backgroundColor = .white
        nameTextField.layer.cornerRadius = 8
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = UIColor.lightGray.cgColor
        nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        nameTextField.leftViewMode = .always
        nameTextField.borderStyle = .none
        nameTextField.isHidden = true
        nameTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        self.addSubview(nameTextField)
        
        nameTextField.snp.makeConstraints { make in
            make.edges.equalTo(nameLabel) // NameLabel ile aynı konumda
            make.height.equalTo(40)
        }
        
        // Email Label
        emailLabel = UILabel()
        emailLabel.text = "Loading..."
        emailLabel.textColor = .white
        emailLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        self.addSubview(emailLabel)
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        // Edit Button
        editButton = UIButton()
        editButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        editButton.tintColor = .white
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        self.addSubview(editButton)
        
        editButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(30)
        }
    }
    
    // MARK: - Configure
    func configure(name: String, email: String) {
        nameLabel.text = name
        nameTextField.text = name
        emailLabel.text = email
    }
    
    private func updateEditingState() {
        nameLabel.isHidden = isEditingName
        nameTextField.isHidden = !isEditingName
        
        let editIcon = isEditingName ? "checkmark.circle.fill" : "square.and.pencil"
        editButton.setImage(UIImage(systemName: editIcon), for: .normal)
        
        if !isEditingName {
            // Düzenleme bittiyse yeni ismi güncelle
            if let newName = nameTextField.text, !newName.isEmpty {
                nameLabel.text = newName
                delegate?.didUpdateName(newName)
            }
        } else {
            // Düzenleme başlıyorsa klavyeyi aç
            nameTextField.becomeFirstResponder()
        }
    }
    
    @objc private func didTapEditButton() {
        isEditingName.toggle()
    }
    
    @objc private func textFieldEditingChanged() {
        nameLabel.text = nameTextField.text
    }
}
