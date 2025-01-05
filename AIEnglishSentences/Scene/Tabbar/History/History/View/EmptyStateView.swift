//
//  EmptyStateView.swift
//  AIEnglishSentences
//
//  Created by mert alp on 3.01.2025.
//


import UIKit
import SnapKit

final class EmptyStateView: UIView {
    
    // MARK: - UI Elements
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .darkGray
        addSubview(titleLabel)
        
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        addSubview(descriptionLabel)
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(250)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Configuration
    func configure(image: UIImage?, title: String, description: String) {
        imageView.image = image
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
