//
//  SocialButtonsView.swift
//  AIEnglishSentences
//
//  Created by mert alp on 3.01.2025.
//

import UIKit
import SnapKit

final class SocialButtonsView: UIView {

    // MARK: - UI Elements
    private var googleButton: AuthButton!
    private var appleButton: AuthButton!
    private var orLabel: UILabel!
    private var actionLabel: UILabel!

    // MARK: - ViewModel
    private var viewModel: SocialButtonsViewModel

    // MARK: - Initialization
    init(viewModel: SocialButtonsViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    private func setupUI() {

        orLabel = UILabel()
        orLabel.text = .localized(for: .orText)
        orLabel.font = .dynamicFont(size: 14, weight: .regular)
        orLabel.textAlignment = .center
        orLabel.textColor = .mainColor
        addSubview(orLabel)

        googleButton = AuthButton(type: .google)
        googleButton.setTitle(viewModel.googleButtonTitle, for: .normal)
        googleButton.addTarget(self, action: #selector(didTapGoogleButton), for: .touchUpInside)
        addSubview(googleButton)

        appleButton = AuthButton(type: .apple)
        appleButton.setTitle(viewModel.appleButtonTitle, for: .normal)
        appleButton.backgroundColor = .black
        appleButton.setTitleColor(.white, for: .normal)
        appleButton.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
        addSubview(appleButton)

        actionLabel = UILabel()
        let attributedString = NSMutableAttributedString(
            string: viewModel.actionText + " ",
            attributes: [.foregroundColor: UIColor.darkGray]
        )
        attributedString.append(NSAttributedString(
            string: viewModel.actionHighlightedText,
            attributes: [
                .foregroundColor: UIColor.mainColor ?? .white,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        ))
        actionLabel.attributedText = attributedString
        actionLabel.font = .dynamicFont(size: 14, weight: .regular)
        actionLabel.textAlignment = .center
        actionLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapActionLabel))
        actionLabel.addGestureRecognizer(tapGesture)
        addSubview(actionLabel)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        orLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        googleButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(UIHelper.dynamicHeight(20))
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(UIHelper.dynamicHeight(40))
        }

        appleButton.snp.makeConstraints { make in
            make.top.equalTo(googleButton.snp.bottom).offset(UIHelper.dynamicHeight(10))
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(UIHelper.dynamicHeight(40))
        }

        actionLabel.snp.makeConstraints { make in
            make.top.equalTo(appleButton.snp.bottom).offset(UIHelper.dynamicHeight(20))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    // MARK: - Actions
    @objc private func didTapGoogleButton() {
        viewModel.handleGoogleButtonTapped()
    }

    @objc private func didTapAppleButton() {
        viewModel.handleAppleButtonTapped()
    }

    @objc private func didTapActionLabel() {
        viewModel.handleActionLabelTapped()
    }
}
