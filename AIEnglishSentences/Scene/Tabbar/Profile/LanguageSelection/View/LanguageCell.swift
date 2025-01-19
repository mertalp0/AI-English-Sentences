//
//  LanguageCell.swift
//  AIEnglishSentences
//
//  Created by mert alp on 5.01.2025.
//

import UIKit

final class LanguageCell: UITableViewCell {

    static let identifier = "LanguageCell"

    private var titleLabel: UILabel!
    private var checkmarkImageView: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none

        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.mainColor?.cgColor
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white

        titleLabel = UILabel()
        titleLabel.font = .dynamicFont(size: 18, weight: .medium)
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)

        checkmarkImageView = UIImageView()
        checkmarkImageView.image = .appIcon(.checkmarkCircle)
        checkmarkImageView.tintColor = .mainColor
        checkmarkImageView.isHidden = true
        contentView.addSubview(checkmarkImageView)

        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }

        checkmarkImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(UIHelper.dynamicHeight(25))
        }
    }

    func configure(with language: String, isSelected: Bool) {
        titleLabel.text = language
        checkmarkImageView.isHidden = !isSelected
    }
}
