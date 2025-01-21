//
//  LanguageSelectionVC+UITableViewDataSource.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

import UIKit

// MARK: - UITableViewDelegate & UITableViewDataSource
extension LanguageSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.identifier, for: indexPath) as? LanguageCell else {
            return UITableViewCell()
        }
        let language = languages[indexPath.row]
        let isSelected = indexPath.row == selectedLanguageIndex
        cell.configure(with: language, isSelected: isSelected)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLanguageIndex = indexPath.row
        tableView.reloadData()
    }
}
