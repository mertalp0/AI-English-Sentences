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
}

final class SentenceCell: UITableViewCell {
    // MARK: - Properties
    weak var delegate: SentenceCellDelegate?
    private var currentSentence: String?

    // MARK: - UI Elements
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.clipsToBounds = false
        return view
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.systemTeal.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.cornerRadius = 16
        return gradient
    }()
    
    private let sentenceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = containerView.bounds
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        
        containerView.layer.insertSublayer(gradientLayer, at: 0)
        
        containerView.addSubview(sentenceLabel)
        containerView.addSubview(playButton)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        sentenceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        playButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(sentenceLabel)
            make.width.height.equalTo(24)
        }

        playButton.addTarget(self, action: #selector(onTapPlay), for: .touchUpInside)
    }
    
    // MARK: - Configure Cell
    func configure(with sentence: String) {
        currentSentence = sentence
        sentenceLabel.text = sentence
    }

    @objc private func onTapPlay() {
        guard let sentence = currentSentence else { return }
        delegate?.didTapPlayButton(for: sentence, in: self)
    }

    func updatePlayButton(isPlaying: Bool) {
        let iconName = isPlaying ? "stop.circle" : "play.circle"
        playButton.setImage(UIImage(systemName: iconName), for: .normal)
    }
}
