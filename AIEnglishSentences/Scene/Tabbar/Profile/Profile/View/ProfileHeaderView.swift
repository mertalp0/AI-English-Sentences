//
//  ProfileHeaderView.swift
//  AIEnglishSentences
//
//  Created by mert alp on 02.01.2025.
//

import UIKit
import SnapKit

final class ProfileHeaderView: UIView {
    
    // MARK: - UI Elements
    private var appBar: AppBar!
    private var avatarImageView: UIImageView!
    private var nameLabel: UILabel!
    private var emailLabel: UILabel!
    private var editButton: UIButton!
    
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
        self.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.top).offset(8)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
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
        self.addSubview(editButton)
        
        editButton.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView)
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(30)
        }
    }
    
    // MARK: - Configure
    func configure(name: String, email: String) {
        nameLabel.text = name
        emailLabel.text = email
    }
}
