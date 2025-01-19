//
//  PrivacyPolicyVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 4.01.2025.
//

import UIKit
import BaseMVVMCKit

final class PrivacyPolicyViewController: BaseViewController<PrivacyPolicyCoordinator, PrivacyPolicyViewModel> {

    // MARK: - UI Elements
    private var backgroundImageView: UIImageView!
    private var appBar: AppBar!
    private var contentTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        backgroundImageView = UIImageView()
        backgroundImageView.image = .appImage(.backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        view.addSubview(backgroundImageView)

        appBar = AppBar(type: .privacyPolicy)
        appBar.delegate = self
        view.addSubview(appBar)

        contentTextView = UITextView()
        contentTextView.isEditable = false
        contentTextView.isScrollEnabled = true
        contentTextView.textColor = .black
        contentTextView.backgroundColor = .clear
        contentTextView.font = .dynamicFont(size: 18, weight: .semibold)
        contentTextView.text = AppConstants.privacyPolicy
        view.addSubview(contentTextView)
    }

    private func setupConstraints() {

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        appBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + UIHelper.dynamicHeight(10))
        }

        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom).offset(UIHelper.dynamicHeight(16))
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-UIHelper.dynamicHeight(16))
        }
    }
}
