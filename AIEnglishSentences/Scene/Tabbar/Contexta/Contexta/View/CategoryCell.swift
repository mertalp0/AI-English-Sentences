//
//  CategoryCell.swift
//  AIEnglishSentences
//
//  Created by mert alp on 27.12.2024.
//

import UIKit
import SnapKit

//MARK: - CellType Enum
enum CellType {
    case professional
    case personal
    case educational
    
    var title: String {
        switch self {
        case .professional:
            return "Professional"
        case .personal:
            return "Personal"
        case .educational:
            return "Educational"
        }
    }
    
    var image: String {
        switch self {
        case .professional:
            return "icon_professional"
        case .personal:
            return "icon_personal"
        case .educational:
            return "icon_educational"
        }
    }
    
    var text: String {
        switch self {
        case .professional:
            return "For polished emails, formal correspondence, or engaging ad scripts."
        case .personal:
            return "For messages to friends, congratulatory notes, or casual posts."
        case .educational:
            return "For simple or advanced sentence building with your chosen word."
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
        iconImageView.image = UIImage(named: type.image)
        containerView.backgroundColor = type.backgroundColor
    }
}
