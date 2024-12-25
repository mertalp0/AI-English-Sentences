//
//  SentencesTableView.swift
//  AIEnglishSentences
//
//  Created by mert alp on 24.12.2024.
//

import UIKit
import SnapKit

final class SentencesTableView: UIView {
    // MARK: - Properties
    private var tableView: UITableView!
    private var currentlyPlayingCell: SentenceCell?
    private let textToSpeechManager =  TextToSpeechManager.shared

    var sentences: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SentenceCell.self, forCellReuseIdentifier: "SentenceCell")
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configure(with sentences: [String]) {
        self.sentences = sentences
    }

    private func stopCurrentSpeaking() {
        currentlyPlayingCell?.updatePlayButton(isPlaying: false)
        textToSpeechManager.stopSpeaking()
        currentlyPlayingCell = nil
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension SentencesTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentences.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SentenceCell", for: indexPath) as? SentenceCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.configure(with: sentences[indexPath.row])
        return cell
    }
}

// MARK: - SentenceCellDelegate
extension SentencesTableView: SentenceCellDelegate {
    func didTapPlayButton(for sentence: String, in cell: SentenceCell) {
        if let currentlyPlayingCell = currentlyPlayingCell, currentlyPlayingCell == cell {
            // Stop current speaking
            stopCurrentSpeaking()
        } else {
            // Stop any ongoing speaking
            stopCurrentSpeaking()
            
            // Start new speaking
            textToSpeechManager.speak(text: sentence)
            cell.updatePlayButton(isPlaying: true)
            currentlyPlayingCell = cell
        }
    }
}
