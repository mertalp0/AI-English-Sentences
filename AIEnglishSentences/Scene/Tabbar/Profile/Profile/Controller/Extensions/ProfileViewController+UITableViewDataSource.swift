//
//  ProfileViewController.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

import UIKit

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
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
