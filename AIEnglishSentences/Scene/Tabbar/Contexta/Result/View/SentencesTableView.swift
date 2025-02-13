//
//  SentencesTableView.swift
//  AIEnglishSentences
//
//  Created by mert alp on 24.12.2024.
//

import UIKit
import SnapKit

protocol SentenceTableViewDelegate: AnyObject {
    func didTapSave(for sentence: Sentence, in cell: SentenceCell)
    func didTapCopyButton(for sentence: String, in cell: SentenceCell)
}

final class SentencesTableView: UIView {

    // MARK: - Properties
    weak var delegate: SentenceTableViewDelegate?
    private var tableView: UITableView!
    private var currentlyPlayingCell: SentenceCell?
    private let textToSpeechManager = TextToSpeechManager.shared

    var sentences: [Sentence] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    func configure(with sentences: [Sentence]) {
        self.sentences = sentences
    }

    // MARK: - Stop Playing
    private func stopCurrentSpeaking() {
        currentlyPlayingCell?.updatePlayButton(isPlaying: false)
        textToSpeechManager.stopSpeaking()
        currentlyPlayingCell = nil
    }
}

// MARK: - UI Setup
private extension SentencesTableView {
    private func setupUI() {
        setupTableView()
        setupConstraints()
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SentenceCell.self, forCellReuseIdentifier: "SentenceCell")
        addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
        cell.configure(with: sentences[indexPath.row], type: .resultCell)
        return cell
    }
}

// MARK: - SentenceCellDelegate
extension SentencesTableView: SentenceCellDelegate {
    func didTapCopyButton(for sentence: String, in cell: SentenceCell) {
        delegate?.didTapCopyButton(for: sentence, in: cell)
    }

    func didTapSaveAndFavorite(
        for sentence: Sentence,
        in cell: SentenceCell
    ) {
        delegate?.didTapSave(for: sentence, in: cell)
    }

    func didTapPlayButton(
        for sentence: String,
        in cell: SentenceCell
    ) {
        if let currentlyPlayingCell = currentlyPlayingCell, currentlyPlayingCell == cell {
            stopCurrentSpeaking()
        } else {
            stopCurrentSpeaking()
            textToSpeechManager.speak(text: sentence)
            cell.updatePlayButton(isPlaying: true)
            currentlyPlayingCell = cell
        }
    }
}
