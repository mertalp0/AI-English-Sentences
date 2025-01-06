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
            return "Maximum Word Count"
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
    private(set) var selectedValue: Int?
    
    weak var delegate: CountSelectorViewDelegate?
    
    init(type: CountSelectorViewType) {
        self.type = type
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        setupOptions()
        selectedValue = type.values.first
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        container.backgroundColor = .white
        container.layer.cornerRadius = 16
        
        titleLabel.text = type.title
        titleLabel.font = .dynamicFont(size: 14, weight: .medium)
        titleLabel.textColor = .gray
        
        optionsStackView.axis = .horizontal
        optionsStackView.alignment = .fill
        optionsStackView.distribution = .fillEqually
        optionsStackView.spacing = 10
        optionsStackView.layer.cornerRadius = 16
        optionsStackView.backgroundColor = .background
        
        container.addSubview(titleLabel)
        container.addSubview(optionsStackView)
        
        addSubview(container)
    }
    
    private func setupConstraints() {

        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIHelper.dynamicHeight(10))
            make.leading.trailing.equalToSuperview().inset(16)
        }

        optionsStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIHelper.dynamicHeight(10))
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-UIHelper.dynamicHeight(10))
            make.height.equalTo(UIHelper.dynamicHeight(50))
        }
    }
    
    private func setupOptions() {
        for value in type.values {
            let button = UIButton(type: .system)
            button.setTitle("\(value)", for: .normal)
            button.titleLabel?.font = .dynamicFont(size: 18, weight: .medium)
            button.setTitleColor(.mainColor, for: .normal)
            button.backgroundColor = .white
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
            optionsStackView.addArrangedSubview(button)
        }
        
        if let firstButton = optionsStackView.arrangedSubviews.first as? UIButton {
            firstButton.backgroundColor = .mainColor?.withAlphaComponent(0.2)
        }
    }
    
    @objc private func optionTapped(_ sender: UIButton) {
        guard let value = sender.titleLabel?.text, let intValue = Int(value) else { return }
        
        selectedValue = intValue
        delegate?.countSelectorView(self, didSelectValue: intValue)
        
        optionsStackView.arrangedSubviews.forEach { view in
            if let button = view as? UIButton {
                button.backgroundColor = .white
            }
        }
        sender.backgroundColor = .mainColor?.withAlphaComponent(0.2)
    }
}
