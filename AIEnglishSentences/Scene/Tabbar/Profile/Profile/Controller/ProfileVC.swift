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
    
    private let options = [
        ("Language", UIImage(systemName: "globe")),
        ("Rate App", UIImage(systemName: "star.fill")),
//        ("Terms & Conditions", UIImage(systemName: "shield")),
        ("Privacy Policy", UIImage(systemName: "doc.text.magnifyingglass")),
        ("Invite Friends", UIImage(systemName: "envelope.fill")),
        ("Apps by Developer", UIImage(systemName: "app.badge.fill"))
    ]
    
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
            make.height.equalTo(250)
        }
        
        // Options TableView
        optionsTableView = UITableView()
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        optionsTableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
        optionsTableView.rowHeight = 60
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
            make.top.equalTo(optionsTableView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-22)
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
            rateApp()
        case 2:
            openPrivacyPolicy()
        case 3:
            inviteFriends()
        case 4:
            openAppsByDeveloper()
        default:
            break
        }
    }
}


//MARK: - Actions
extension ProfileVC {
    
    private func changeLanguage() {
       
    }
    
    private func rateApp() {

    }
    
    private func openPrivacyPolicy() {
 
    }
    
    private func openAppsByDeveloper() {
   
    }
    
    private func inviteFriends() {
        print("Invite friends action triggered")
        coordinator?.shareApp()
    }
    
    @objc private func onLogoutButtonPressed() {
        let logoutAlertVC = LogoutAlertViewController()
        logoutAlertVC.onCancel = {
            print("Logout canceled")
        }
        logoutAlertVC.onLogout = { [weak self] in
            guard let self = self else { return }
            self.performLogout()
        }
        logoutAlertVC.modalPresentationStyle = .overFullScreen
        logoutAlertVC.modalTransitionStyle = .crossDissolve
        present(logoutAlertVC, animated: true)
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
}

