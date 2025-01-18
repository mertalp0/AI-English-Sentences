//
//  GenerateTextView.swift
//  AIEnglishSentences
//
//  Created by mert alp on 17.12.2024.
//

import UIKit
import SnapKit

final class GenerateTextView: UITextView {

    // MARK: - Placeholder Label
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = .dynamicFont(size: 14)
        label.textColor = .gray
        label.text = .localized(for: .generateTextViewPlaceholder)
        return label
    }()

    // MARK: - Maximum Line Count
    private var maxNumberOfLines: Int = 5

    // MARK: - Initialization
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup
    private func setupView() {

        self.backgroundColor = .backgroundColor
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.textColor = .black
        self.font = .dynamicFont(size: 16)
        self.isScrollEnabled = false
        self.textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        self.delegate = self

        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(UIHelper.dynamicHeight(8))
        }
    }

    // MARK: - Update Placeholder Visibility
    private func updatePlaceholderVisibility() {
        placeholderLabel.isHidden = !self.text.isEmpty
    }

    // MARK: - Set Maximum Line Count
    func setMaxNumberOfLines(_ lines: Int) {
        self.maxNumberOfLines = lines
    }

    // MARK: - Dynamic Height Calculation
    private func calculateHeight() -> CGFloat {
        guard let font = self.font else { return 0 }
        let lineHeight = font.lineHeight
        return lineHeight * CGFloat(maxNumberOfLines)
    }
}

// MARK: - UITextViewDelegate
extension GenerateTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updatePlaceholderVisibility()
        let maxHeight = calculateHeight()
        if self.contentSize.height > maxHeight {
            self.isScrollEnabled = true
            self.isScrollEnabled = false
        }
    }
}
