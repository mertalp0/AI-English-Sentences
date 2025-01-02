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
        ("Rate App", UIImage(systemName: "star")),
        ("Terms & Conditions", UIImage(systemName: "doc.text")),
        ("Privacy Policy", UIImage(systemName: "lock")),
        ("Invite Friends", UIImage(systemName: "envelope"))
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupActions()
        fetchUserData()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        // Profile Header
        profileHeaderView = ProfileHeaderView()
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = options[indexPath.row]
        print("Tapped on: \(option.0)")
    }
}


//MARK: - Actions
extension ProfileVC {
    
    @objc private func onLogoutButtonPressed() {
        tabBarController?.tabBar.isUserInteractionEnabled = false
        viewModel.logout { isSucces in
            switch isSucces {
            case true:
                self.coordinator?.showInfo()
                
            case false:
                self.tabBarController?.tabBar.isUserInteractionEnabled = true
                print("Kayıt sırasında bir hata oluştu.")
            }
        }
    }
    

    @objc private func onTapIqTest() {
        print("IQ Test Button tapped")
        viewModel.openIqTestApp { success in
            if success {
                print("Uygulama açıldı veya App Store yönlendirmesi yapıldı.")
            } else {
                print("Uygulama açma işlemi başarısız.")
            }
        }
    }
    
    @objc private func onTapShare() {
        coordinator?.shareApp()
    }
}
