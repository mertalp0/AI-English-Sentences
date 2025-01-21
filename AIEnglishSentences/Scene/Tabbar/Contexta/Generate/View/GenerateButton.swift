//
//  GenerateButton.swift
//  AIEnglishSentences
//
//  Created by mert alp on 28.12.2024.
//

import UIKit
import SnapKit

final class GenerateButton: UIButton {

    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupUI()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupActions() {
        addTarget(self, action: #selector(animateDown), for: .touchDown)
        addTarget(self, action: #selector(animateUp), for: [.touchUpInside, .touchCancel, .touchDragExit])
    }

    @objc private func animateDown() {
        self.animateScaleDown()
    }

    @objc private func animateUp() {
        self.animateScaleUp()
    }
}

// MARK: - Setup
extension GenerateButton {
    private func  setupUI() {
        setupButton()
    }

    private func setupButton() {
        self.backgroundColor = .mainColor
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.setTitle(.localized(for: .generateButtonTitle), for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .dynamicFont(size: 16, weight: .semibold)

        let icon = UIImage.appImage(.wandAndStars)
        self.setImage(icon?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.tintColor = .white
        self.imageView?.contentMode = .scaleAspectFit
        self.semanticContentAttribute = .forceRightToLeft

        self.snp.makeConstraints { make in
            make.height.equalTo(UIHelper.dynamicHeight(40))
        }
    }

}
