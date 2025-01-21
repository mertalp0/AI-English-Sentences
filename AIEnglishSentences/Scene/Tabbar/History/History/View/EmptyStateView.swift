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
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!

    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    func configure(image: UIImage?, title: String, description: String) {
        imageView.image = image
        titleLabel.text = title
        descriptionLabel.text = description
    }
}

// MARK: - Setup UI
private extension EmptyStateView {
    private func setupUI() {
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }

    private func setupImageView() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(UIHelper.dynamicHeight(250))
        }
    }

    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = .dynamicFont(size: 18, weight: .bold)
        titleLabel.textColor = .darkGray
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(UIHelper.dynamicHeight(16))
            make.leading.trailing.equalToSuperview()
        }
    }

    private func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = .dynamicFont(size: 14, weight: .regular)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        addSubview(descriptionLabel)

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIHelper.dynamicHeight(8))
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
