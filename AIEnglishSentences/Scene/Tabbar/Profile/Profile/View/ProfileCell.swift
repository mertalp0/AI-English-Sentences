//
//  ProfileCell.swift
//  AIEnglishSentences
//
//  Created by mert alp on 02.01.2025.
//

import UIKit
import SnapKit

final class ProfileCell: UITableViewCell {
    
    // MARK: - UI Elements
    private var iconImageView: UIImageView!
    private var titleLabel: UILabel!
    private var arrowImageView: UIImageView!
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        // Icon Image
        iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .mainColor
        contentView.addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(28) // İkon biraz daha büyük
        }
        
        // Title Label
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium) // Daha büyük font
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
        
        // Arrow Image
        arrowImageView = UIImageView()
        arrowImageView.image = UIImage(systemName: "chevron.right")
        arrowImageView.tintColor = .lightGray
        contentView.addSubview(arrowImageView)
        
        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Configure Cell
    func configure(with title: String, icon: UIImage?) {
        titleLabel.text = title
        iconImageView.image = icon
    }
}
