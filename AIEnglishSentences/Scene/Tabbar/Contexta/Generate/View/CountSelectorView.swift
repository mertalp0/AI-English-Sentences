//
//  CountSelectorView.swift
//  AIEnglishSentences
//
//  Created by mert alp on 27.12.2024.
//

import UIKit
import SnapKit

enum CountSelectorViewType {
    case sentence
    case word
    
    var title: String {
        switch self {
        case .sentence:
            return "Sentence Count"
        case .word:
            return "Word Count"
        }
    }
    
    var values: [Int] {
        switch self {
        case .sentence:
            return [5, 10, 15, 20]
        case .word:
            return [5, 15, 25, 35]
        }
    }
}

protocol CountSelectorViewDelegate: AnyObject {
    func countSelectorView(_ view: CountSelectorView, didSelectValue value: Int)
}

final class CountSelectorView: UIView {
    
    let type: CountSelectorViewType
    private let container = UIView()
    private let titleLabel = UILabel()
    private let optionsStackView = UIStackView()
    
    weak var delegate: CountSelectorViewDelegate?
    
    init(type: CountSelectorViewType) {
        self.type = type
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        setupOptions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        container.backgroundColor = .white
        container.layer.cornerRadius = 16
        
        titleLabel.text = type.title
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .gray
        
        optionsStackView.axis = .horizontal
        optionsStackView.alignment = .fill
        optionsStackView.distribution = .fillEqually
        optionsStackView.spacing = 10
        optionsStackView.layer.cornerRadius = 16
        optionsStackView.backgroundColor = UIColor(hex: "E9F1FF")
        
        container.addSubview(titleLabel)
        container.addSubview(optionsStackView)
        
        addSubview(container)
    }
    
    private func setupConstraints() {

        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        optionsStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
    }
    
    private func setupOptions() {
        for value in type.values {
            let button = UIButton(type: .system)
            button.setTitle("\(value)", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            button.setTitleColor(.systemBlue, for: .normal)
            button.backgroundColor = .white
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
            optionsStackView.addArrangedSubview(button)
        }
    }
    
    @objc private func optionTapped(_ sender: UIButton) {
        guard let value = sender.titleLabel?.text, let intValue = Int(value) else { return }
        
        delegate?.countSelectorView(self, didSelectValue: intValue)
        
        self.optionsStackView.arrangedSubviews.forEach { view in
            if let button = view as? UIButton {
                button.animateBackgroundColor(to: .white)
            }
        }
        
        sender.animateBackgroundColor(to: .systemBlue.withAlphaComponent(0.2))
    }
}
