//
//  GenerateLoadingView.swift
//  AIEnglishSentences
//
//  Created by mert alp on 29.12.2024.
//

import UIKit

final class GenerateLoadingView: UIView {

    // MARK: - UI Elements
    private var animatedIcon: UIImageView!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - Setup UI
private extension GenerateLoadingView {
    private func setupUI() {
        backgroundColor = UIColor.white
        setupAnimatedIcon()
        setupTitleLabel()
        setupDescriptionLabel()
    }

    private func setupAnimatedIcon() {
        animatedIcon = UIImageView()
        animatedIcon.image = .appImage(.loadingImage)
        animatedIcon.contentMode = .scaleAspectFit
        addSubview(animatedIcon)

        animatedIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(UIHelper.dynamicHeight(204))
            make.width.equalTo(UIHelper.dynamicWidth(345))
            make.height.equalTo(UIHelper.dynamicHeight(259))
        }
    }

    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = .localized(for: .generateLoadingTitle)
        titleLabel.font = .dynamicFont(size: 18, weight: .semibold)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(animatedIcon.snp.bottom).offset(UIHelper.dynamicHeight(74))
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }

    private func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.text = .localized(for: .generateLoadingDescription)
        descriptionLabel.font = .dynamicFont(size: 14, weight: .regular)
        descriptionLabel.textColor = UIColor.gray
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        addSubview(descriptionLabel)

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIHelper.dynamicHeight(16))
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
}
