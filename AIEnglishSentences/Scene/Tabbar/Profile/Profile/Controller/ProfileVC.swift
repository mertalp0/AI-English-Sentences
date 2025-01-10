//
//  ProfileVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 02.01.2025.
//

import UIKit
import SnapKit
import BaseMVVMCKit

final class ProfileVC: BaseViewController<ProfileCoordinator, ProfileViewModel> {
    
    // MARK: - UI Elements
    private var profileHeaderView: ProfileHeaderView!
    private var optionsTableView: UITableView!
    private var logoutButton: UIButton!
    
    private let options: [(String, UIImage?)] = {
        var items: [(String, UIImage?)] = [
            ("Language", .appIcon(.globe)),
            ("Privacy Policy", .appIcon(.textMagnifyingGlass)),
            ("Invite Friends", .appIcon(.envelope)),
            ("Apps by Developer", .appIcon(.appBadge)),
            ("Delete Account", .appIcon(.binCircle))
        ]

        if #available(iOS 14.0, *) {
            items.insert(("Rate App", .appIcon(.star)), at: 5)
        }
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
    
    // MARK: - Setup UI
    private func setupUI() {
        // Profile Header
        profileHeaderView = ProfileHeaderView()
        profileHeaderView.delegate = self
        view.addSubview(profileHeaderView)
        
        profileHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIHelper.dynamicHeight(250))
        }
        
        // Options TableView
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
        
        // Logout Button
        logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Log Out", for: .normal)
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

// MARK: - ProfileHeaderViewDelegate
extension ProfileVC: ProfileHeaderViewDelegate {
    func didUpdateName(_ newName: String) {
        viewModel.updateUser(name: newName) { isSuccess in
            if isSuccess {
                print("Name updated successfully")
            } else {
                print("Failed to update name")
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileCell else {
            return UITableViewCell()
        }
        let option = options[indexPath.row]
        cell.configure(with: option.0, icon: option.1)
        cell.enablePressAnimation()
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dismissKeyboard()
        
        switch indexPath.row {
        case 0:
            print("Invite friends action triggered")
            changeLanguage()
        case 1:
            openPrivacyPolicy()
        case 2:
            inviteFriends()
        case 3:
            openAppsByDeveloper()
        case 4:
            deleteAccount()
        case 5:
            rateApp()
            
        default:
            break
        }
    }
}


//MARK: - Actions
extension ProfileVC {
    
    private func changeLanguage() {
        coordinator?.showLanguagePage()
    }
    
    private func rateApp() {
        if #available(iOS 14.0, *) {
            viewModel.rateAppInAppStore()
        } else {
            
        }
    }
    
    private func openPrivacyPolicy() {
        coordinator?.showPrivacyPolicy()
    }
    
    private func openAppsByDeveloper() {
        coordinator?.showApps()
    }
    
    private func inviteFriends() {
        print("Invite friends action triggered")
        coordinator?.shareApp()
    }
    
    private func deleteAccount(){
        let deletePopup = PopupViewController(
            popupType: .delete,
            icon: .appIcon(.trash),
            cancelText: "Cancel",
            confirmText: "Delete"
        )
        deletePopup.delegate = self
        deletePopup.modalPresentationStyle = .overFullScreen
        deletePopup.modalTransitionStyle = .crossDissolve
        present(deletePopup, animated: true)
    }
    
    @objc private func onLogoutButtonPressed() {
        let logoutPopup = PopupViewController(
            popupType: .logout,
            icon: .appIcon(.logout),
            cancelText: "Cancel",
            confirmText: "Logout"
        )
        logoutPopup.delegate = self
        logoutPopup.modalPresentationStyle = .overFullScreen
        logoutPopup.modalTransitionStyle = .crossDissolve
        present(logoutPopup, animated: true)
        
    }
    
    private func performLogout() {
        tabBarController?.tabBar.isUserInteractionEnabled = false
        viewModel.logout { isSuccess in
            if isSuccess {
                self.coordinator?.showInfo()
            } else {
                self.tabBarController?.tabBar.isUserInteractionEnabled = true
                print("Logout error occurred.")
            }
        }
    }
    
    private func performDelete() {
        tabBarController?.tabBar.isUserInteractionEnabled = false
        viewModel.deleteAccount { isSuccess in
            if isSuccess {
                self.coordinator?.showInfo()
            } else {
                self.tabBarController?.tabBar.isUserInteractionEnabled = true
                print("Delete Account error.")
            }
        }
    }
}


extension ProfileVC: PopupViewControllerDelegate {
    func popupDidCancel(popupType: PopupType) {
        switch popupType {
        case .logout:
            coordinator?.navigationController?.dismiss(animated: true)
        case .delete:
            coordinator?.navigationController?.dismiss(animated: true)
        case .custom(let title, _):
            print("\(title) cancelled")
        }
    }
    
    func popupDidConfirm(popupType: PopupType) {
        switch popupType {
        case .logout:
            performLogout()
        case .delete:
            performDelete()
        case .custom(let title, _):
            print("\(title) confirmed")
        }
    }
}
