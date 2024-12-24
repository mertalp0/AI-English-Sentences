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
    var sentences: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var onSentenceSelected: ((String) -> Void)?
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
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
    
    // MARK: - Configure
    func configure(with sentences: [String], onSelect: @escaping (String) -> Void) {
        self.sentences = sentences
        self.onSentenceSelected = onSelect
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
        cell.configure(with: sentences[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSentence = sentences[indexPath.row]
        onSentenceSelected?(selectedSentence)
    }
}
