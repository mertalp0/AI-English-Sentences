//
//  HistoryVC+CustomSegmentedControlDelegate.swift
//  AIEnglishSentences
//
//  Created by mert alp on 19.01.2025.
//

// MARK: - CustomSegmentedControlDelegate
extension HistoryViewController: HistorySegmentedControlDelegate {
    func segmentChanged(to index: Int) {
        updateUIForCurrentData()
    }
}
