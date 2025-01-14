//
//  GenerateCell.swift
//  AIEnglishSentences
//
//  Created by mert alp on 24.12.2024.
//

//import UIKit
//import SnapKit
//
//final class GenerateCell: UITableViewCell {
//    // MARK: - UI Elements
//    private let containerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        view.layer.cornerRadius = 12
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOpacity = 0.1
//        view.layer.shadowOffset = CGSize(width: 0, height: 2)
//        view.layer.shadowRadius = 4
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.lightGray.cgColor
//        return view
//    }()
//    
//    private let wordsLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//        label.textColor = .black
//        label.numberOfLines = 1
//        return label
//    }()
//    
//    private let sentenceCountLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        label.textColor = .darkGray
//        label.numberOfLines = 1
//        return label
//    }()
//    
//    // MARK: - Initializer
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        selectionStyle = .none
//        backgroundColor = .clear
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - Setup UI
//    private func setupUI() {
//        contentView.backgroundColor = .clear
//        contentView.addSubview(containerView)
//        containerView.addSubview(wordsLabel)
//        containerView.addSubview(sentenceCountLabel)
//        
//        containerView.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(8)
//        }
//        
//        wordsLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(12)
//            make.leading.equalToSuperview().offset(16)
//            make.trailing.equalToSuperview().offset(-16)
//        }
//        
//        sentenceCountLabel.snp.makeConstraints { make in
//            make.top.equalTo(wordsLabel.snp.bottom).offset(8)
//            make.leading.equalToSuperview().offset(16)
//            make.trailing.equalToSuperview().offset(-16)
//            make.bottom.equalToSuperview().offset(-12)
//        }
//    }
//    
//    // MARK: - Configure Cell
//    func configure(with model: GenerateModel) {
//        wordsLabel.text = "Words: \(model.words)"
//        sentenceCountLabel.text = "Sentences: \(model.sentences.count)"
//    }
//}
