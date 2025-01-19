//
//  MyAppsViewController+UITableViewDataSource.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

import UIKit

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MyAppsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppCell", for: indexPath) as? AppCell else {
            return UITableViewCell()
        }
        cell.configure(with: apps[indexPath.row])
        return cell
    }
}
