//
//  CategoryCell.swift
//  AIEnglishSentences
//
//  Created by mert alp on 27.12.2024.
//

import UIKit
import SnapKit

final class CategoryCell: UITableViewCell {
    // MARK: - UI Elements
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .dynamicFont(size: 20, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .dynamicFont(size: 16, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
            make.height.equalTo(UIHelper.dynamicHeight(150))
        }

        iconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(UIHelper.dynamicHeight(120))

        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIHelper.dynamicHeight(16))
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(iconImageView.snp.leading).offset(-16)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIHelper.dynamicHeight(8))
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(iconImageView.snp.leading).offset(-16)
            make.bottom.equalToSuperview().offset(-UIHelper.dynamicHeight(16))
        }
    }

    // MARK: - Configure Cell
    func configure(with type: CellType) {
        titleLabel.text = type.title
        descriptionLabel.text = type.text
        iconImageView.image = type.image
        containerView.backgroundColor = type.backgroundColor
    }
}

// MARK: - CellType Enum
enum CellType {
    case professional
    case personal
    case educational

    var title: String {
         switch self {
         case .professional:
             return .localized(for: .categoryProfessionalTitle)
         case .personal:
             return .localized(for: .categoryPersonalTitle)
         case .educational:
             return .localized(for: .categoryEducationalTitle)
         }
     }

     var image: UIImage? {
         switch self {
         case .professional:
             return .appImage(.professional)
         case .personal:
             return  .appImage(.personal)
         case .educational:
             return  .appImage(.educational)
         }
     }

     var text: String {
         switch self {
         case .professional:
             return .localized(for: .categoryProfessionalDescription)
         case .personal:
             return .localized(for: .categoryPersonalDescription)
         case .educational:
             return .localized(for: .categoryEducationalDescription)
         }
     }

    var backgroundColor: UIColor {
        switch self {
        case .professional:
            return UIColor(red: 45/255, green: 140/255, blue: 240/255, alpha: 1)
        case .personal:
            return UIColor(red: 240/255, green: 100/255, blue: 120/255, alpha: 1)
        case .educational:
            return UIColor(red: 130/255, green: 100/255, blue: 240/255, alpha: 1)
        }
    }
}
