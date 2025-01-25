//
//  HistoryVC+UITableViewDataSource.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

import UIKit

// MARK: - UITableViewDataSource
extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SentenceCell", for: indexPath) as? SentenceCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.configure(with: currentData[indexPath.row], type: .historyCell)
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        if historySegmentedControl.selectedIndex != 0 {
            return nil
        }

        let sentence = currentData[indexPath.row]

        let deleteAction = UIContextualAction(style: .destructive, title: .localized(for: .historyDeleteAlertConfirm)) { [weak self] _, _, completionHandler in
            guard let self = self else { return }
            self.didTapDelete(for: sentence, in: tableView.cellForRow(at: indexPath) as! SentenceCell)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .systemRed

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
