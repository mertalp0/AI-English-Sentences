//
//  AuthBar.swift
//  AIEnglishSentences
//
//  Created by mert alp on 4.01.2025.
//


import UIKit
import SnapKit

protocol AuthBarDelegate: AnyObject {
    func didTapBackButton()
}

final class AuthBar: UIView {

    // MARK: - UI Elements
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        let backIcon = UIImage(systemName: "chevron.left")
        let resizedRightIcon = backIcon?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 22, weight: .bold))
        button.setImage(resizedRightIcon, for: .normal)
        button.tintColor = .init(hex: "1F41BB")
        button.contentHorizontalAlignment = .leading
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .init(hex: "1F41BB")
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Delegate
    weak var delegate: AuthBarDelegate?

    // MARK: - Initialization
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        setupUI()
        setupConstraints()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    private func setupUI() {
        addSubview(backButton)
        addSubview(titleLabel)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24) // İkon boyutu
        }

        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.greaterThanOrEqualTo(backButton.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
    }

    // MARK: - Setup Actions
    private func setupActions() {
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func didTapBackButton() {
        delegate?.didTapBackButton()
    }
}
