//
//  GenerateLoadingView.swift
//  AIEnglishSentences
//
//  Created by mert alp on 29.12.2024.
//

import UIKit

final class GenerateLoadingView: UIView {

    // MARK: - UI Elements
    private let animatedIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  .appImage(.loadingImage)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localized(for: .generateLoadingTitle)
        label.font = .dynamicFont(size: 18, weight: .semibold)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = .localized(for: .generateLoadingDescription)
        label.font = .dynamicFont(size: 14, weight: .regular)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup View
    private func setupView() {
        backgroundColor = UIColor.white
        addSubview(animatedIcon)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        animatedIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(UIHelper.dynamicHeight(204))
            make.width.equalTo(UIHelper.dynamicWidth(345))
            make.height.equalTo(UIHelper.dynamicHeight(259))
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(animatedIcon.snp.bottom).offset(UIHelper.dynamicHeight(74))
            make.leading.trailing.equalToSuperview().inset(24)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIHelper.dynamicHeight(16))
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
}
