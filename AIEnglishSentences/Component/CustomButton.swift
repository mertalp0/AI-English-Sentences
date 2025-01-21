//
//  CustomButton.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import UIKit
import SnapKit

final class CustomButton: UIButton {

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    private func setupUI() {
        setupStyle()
        setupActions()
    }

    private func setupStyle() {
        backgroundColor = .mainColor
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .dynamicFont(size: 16, weight: .semibold)
        layer.cornerRadius = 8
        layer.masksToBounds = true

        snp.makeConstraints { make in
            make.width.equalTo(200)
        }
    }

    private func setupActions() {
        addTarget(self, action: #selector(animateDown), for: .touchDown)
        addTarget(self, action: #selector(animateUp), for: [.touchUpInside, .touchCancel, .touchDragExit])
    }

    // MARK: - Configuration
    func configure(
        title: String,
        backgroundColor: UIColor? = nil,
        textColor: UIColor? = nil
    ) {
        setTitle(title, for: .normal)
        if let bgColor = backgroundColor {
            self.backgroundColor = bgColor
        }
        if let txtColor = textColor {
            setTitleColor(txtColor, for: .normal)
        }
    }

    // MARK: - Animations
    @objc private func animateDown() {
        self.animateScaleDown()
    }

    @objc private func animateUp() {
        self.animateScaleUp()
    }
}
