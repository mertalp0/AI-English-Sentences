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
        self.layer.cornerRadius = 14
        self.clipsToBounds = false
        self.setTitle(.localized(for: .generateButtonTitle), for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .dynamicFont(size: 17, weight: .bold)

        let icon = UIImage.appImage(.wandAndStars)
        self.setImage(icon?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.tintColor = .white
        self.imageView?.contentMode = .scaleAspectFit
        self.semanticContentAttribute = .forceRightToLeft
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)

        // Premium shadow
        self.layer.shadowColor = UIColor.mainColor?.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 6)
        self.layer.shadowRadius = 12
        self.layer.shadowOpacity = 0.35

        self.snp.makeConstraints { make in
            make.height.equalTo(UIHelper.dynamicHeight(52))
        }
    }

}
