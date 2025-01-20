//
//  InfoVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import UIKit
import BaseMVVMCKit
import SnapKit

final class InfoViewController: BaseViewController<InfoCoordinator, InfoViewModel> {

    // MARK: - UI Elements
    private var backgroundImageView: UIImageView!
    private var logoImageView: UIImageView!
    private var subtitleLabel: UILabel!
    private var loginButton: AuthButton!
    private var socialButtonsView: SocialButtonsView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAll()
    }

    private func setupAll() {
        setupUI()
        setupConstraints()
    }

    // MARK: - Setup UI
    private func setupUI() {
        backgroundImageView = UIImageView()
        backgroundImageView.image = .appImage(.backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        view.addSubview(backgroundImageView)

        logoImageView = UIImageView()
        logoImageView.image = .appImage(.aiLexText)
        logoImageView.contentMode = .scaleAspectFit
        view.addSubview(logoImageView)

        subtitleLabel = UILabel()
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = UIColor.darkGray
        subtitleLabel.attributedText = NSAttributedString(
            string: .localized(for: .infoSubTitle),
            attributes: [
                .font: UIFont.dynamicFont(size: 22, weight: .bold),
                .foregroundColor: UIColor.darkGray,
                .kern: 1.0,
                .paragraphStyle: {
                    let style = NSMutableParagraphStyle()
                    style.lineSpacing = 5
                    style.alignment = .center
                    return style
                }()
            ]
        )
        view.addSubview(subtitleLabel)

        loginButton = AuthButton(type: .normal(title: .login))
        loginButton.backgroundColor = .main
        loginButton.delegate = self
        view.addSubview(loginButton)

        socialButtonsView = SocialButtonsView(
                googleButtonTitle: .localized(for: .googleButtonTitle),
                appleButtonTitle: .localized(for: .appleButtonTitle),
                actionText: .localized(for: .dontHaveAccount),
                actionHighlightedText: .localized(for: .signup)
        )
        socialButtonsView.delegate = self
        view.addSubview(socialButtonsView)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(UIHelper.dynamicHeight(90))
            make.centerX.equalToSuperview()
            make.width.equalTo(UIHelper.dynamicWidth(250))
            make.height.equalTo(UIHelper.dynamicHeight(80))
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(UIHelper.dynamicHeight(32))
            make.leading.trailing.equalToSuperview().inset(32)
        }

        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(socialButtonsView.snp.top).offset(-UIHelper.dynamicHeight(30))
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(UIHelper.dynamicHeight(40))
        }

        socialButtonsView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-UIHelper.dynamicHeight(20))
            make.leading.trailing.equalToSuperview()
        }
    }
}
