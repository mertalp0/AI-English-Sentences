//
//  ProfileVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 02.01.2025.
//

import UIKit
import SnapKit
import BaseMVVMCKit

final class ProfileViewController: BaseViewController<ProfileCoordinator, ProfileViewModel> {

    // MARK: - UI Elements
    private var profileHeaderView: ProfileHeaderView!
    private var optionsTableView: UITableView!
    private var logoutButton: UIButton!

    let options: [(String, UIImage?)] = {
        var items: [(String, UIImage?)] = [
            (.localized(for: .profileLanguage), .appIcon(.globe)),
            (.localized(for: .profilePrivacyPolicy), .appIcon(.textMagnifyingGlass)),
            (.localized(for: .profileInviteFriends), .appIcon(.envelope)),
            (.localized(for: .profileAppsByDeveloper), .appIcon(.appBadge)),
            (.localized(for: .profileDeleteAccount), .appIcon(.binCircle)),
            (.localized(for: .profileRateApp), .appIcon(.star))
        ]
        return items
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupActions()
        fetchUserData()
        setupKeyboardDismissRecognizer()
    }

    // MARK: - Setup Actions
    private func setupActions() {
        logoutButton.addTarget(self, action: #selector(onLogoutButtonPressed), for: .touchUpInside)
    }

    private func fetchUserData() {
        viewModel.getUser { [weak self] user in
            guard let self = self else { return }
            self.profileHeaderView.configure(name: user.name, email: user.email)
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dismissKeyboard()
    }
}

// MARK: - SetupUI
private extension ProfileViewController {

    private func setupUI() {
        setupProfileHeaderView()
        setupOptionsTableView()
        setupLogoutButton()
    }

    private func setupProfileHeaderView() {
        profileHeaderView = ProfileHeaderView()
        profileHeaderView.delegate = self
        view.addSubview(profileHeaderView)

        profileHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIHelper.dynamicHeight(250))
        }
    }

    private func setupOptionsTableView() {
        optionsTableView = UITableView()
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        optionsTableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
        optionsTableView.rowHeight = UIHelper.dynamicHeight(60)
        optionsTableView.isScrollEnabled = false
        optionsTableView.backgroundColor = .clear
        view.addSubview(optionsTableView)

        optionsTableView.snp.makeConstraints { make in
            make.top.equalTo(profileHeaderView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(80)
        }
    }

    private func setupLogoutButton() {
        logoutButton = UIButton(type: .system)
        logoutButton.setTitle(.localized(for: .profileLogout), for: .normal)
        logoutButton.setTitleColor(.systemRed, for: .normal)
        logoutButton.layer.cornerRadius = 10
        logoutButton.layer.borderWidth = 1
        logoutButton.layer.borderColor = UIColor.systemRed.cgColor
        view.addSubview(logoutButton)

        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(optionsTableView.snp.bottom).offset(UIHelper.dynamicHeight(16))
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(UIHelper.dynamicHeight(40))
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-UIHelper.dynamicHeight(22))
        }
    }
}
