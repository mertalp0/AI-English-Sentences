//
//  SentenceCell.swift
//  AIEnglishSentences
//
//  Created by mert alp on 24.12.2024.
//

import UIKit
import SnapKit

protocol SentenceCellDelegate: AnyObject {
    func didTapPlayButton(for sentence: String, in cell: SentenceCell)
    func didTapSaveAndFavorite(for sentence: NewSentence, in cell: SentenceCell)
    func didTapCopyButton(for sentence: String, in cell: SentenceCell)
}
enum SentenceCellType {
    case historyCell
    case resultCell
}

final class SentenceCell: UITableViewCell {
    // MARK: - Properties
    weak var delegate: SentenceCellDelegate?
    private var currentSentence: NewSentence?
    private var type: SentenceCellType? {
        didSet {
            updateSaveAndFavoriteButton()
        }
    }
    
    // MARK: - UI Elements
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    private let sentenceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.tintColor = .mainColor
        return button
    }()
    
    private let saveAndFavoriteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemYellow
        return button
    }()
    
    private let copyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        button.tintColor = .systemGreen
        return button
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return view
    }()
    
    private let metadataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private let writingToneContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()

    private let writingToneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    private let writingStyleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemTeal
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()

    private let writingStyleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let createdAtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .darkGray
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        containerView.addSubview(sentenceLabel)
        containerView.addSubview(playButton)
        containerView.addSubview(saveAndFavoriteButton)
        containerView.addSubview(copyButton)
        containerView.addSubview(separatorLine)
        containerView.addSubview(metadataStackView)
        
        sentenceLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(playButton.snp.leading).offset(-8)
        }
        
        playButton.snp.makeConstraints { make in
            make.trailing.equalTo(saveAndFavoriteButton.snp.leading).offset(-8)
            make.top.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
        }
        
        saveAndFavoriteButton.snp.makeConstraints { make in
            make.trailing.equalTo(copyButton.snp.leading).offset(-8)
            make.top.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
        }
        
        copyButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
        }
        
        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(sentenceLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        metadataStackView.addArrangedSubview(writingToneContainer)
        metadataStackView.addArrangedSubview(writingStyleContainer)

        writingToneContainer.addSubview(writingToneLabel)
        writingToneLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8) 
        }

        writingStyleContainer.addSubview(writingStyleLabel)
        writingStyleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        metadataStackView.addArrangedSubview(createdAtLabel)
        
        metadataStackView.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        
        playButton.addTarget(self, action: #selector(onTapPlay), for: .touchUpInside)
        saveAndFavoriteButton.addTarget(self, action: #selector(onTapSaveAndFavorite), for: .touchUpInside)
        copyButton.addTarget(self, action: #selector(onTapCopy), for: .touchUpInside)
    }
    
    // MARK: - Configure Cell
    func configure(with sentence: NewSentence, type: SentenceCellType) {
        self.currentSentence = sentence
        self.type = type
        sentenceLabel.text = sentence.sentence
        writingToneLabel.text = sentence.writingTone
        writingStyleLabel.text = sentence.writingStyle
        createdAtLabel.text = DateFormatter.localizedString(from: sentence.createdAt, dateStyle: .medium, timeStyle: .none)
        updateSaveAndFavoriteButton()
    }
    
    func updateSaveAndFavoriteButton() {
        guard let sentence = currentSentence else { return }
        let icon: String
        switch type {
        case .historyCell:
            icon = sentence.favorite ? "star.fill" : "star"
        case .resultCell:
            if SentenceManager.shared.sentences.contains(where: { $0.id == sentence.id }) {
                icon = "bookmark.fill"
            } else {
                icon = "bookmark"
            }
        case .none:
            return
        }
        saveAndFavoriteButton.setImage(UIImage(systemName: icon), for: .normal)
    }
    
    func updatePlayButton(isPlaying: Bool) {
        let iconName = isPlaying ? "stop.circle" : "play.circle"
        playButton.setImage(UIImage(systemName: iconName), for: .normal)
    }
    
    // MARK: - Actions
    @objc private func onTapPlay() {
        guard let sentence = currentSentence else { return }
        delegate?.didTapPlayButton(for: sentence.sentence, in: self)
    }
    
    @objc private func onTapSaveAndFavorite() {
        guard let sentence = currentSentence else { return }
        delegate?.didTapSaveAndFavorite(for: sentence, in: self)
    }
    
    func updateSaveAndFavoriteButton(for sentence: NewSentence) {
        let icon: String
        if SentenceManager.shared.sentences.contains(where: { $0.id == sentence.id }) {
            icon = "bookmark.fill"
        } else {
            icon = "bookmark"
        }
        UIView.transition(with: saveAndFavoriteButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.saveAndFavoriteButton.setImage(UIImage(systemName: icon), for: .normal)
        })
    }
    
    @objc private func onTapCopy() {
          guard let sentence = currentSentence else { return }
          delegate?.didTapCopyButton(for: sentence.sentence, in: self)
      }
}
