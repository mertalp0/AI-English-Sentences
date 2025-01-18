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
        setupButton()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
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
        self.adjustsImageWhenHighlighted = false
        self.adjustsImageWhenDisabled = false
        
        self.semanticContentAttribute = .forceRightToLeft
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 2)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: -2)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(UIHelper.dynamicHeight(40))
        }
    }
    
    private func setupActions() {
        addTarget(self, action: #selector(animateDown), for: .touchDown)
        addTarget(self, action: #selector(animateUp), for: [.touchUpInside, .touchCancel, .touchDragExit])
    }
    
    // MARK: - Animation Methods
    @objc private func animateDown() {
        self.animateScaleDown()
    }
    
    @objc private func animateUp() {
        self.animateScaleUp()
    }
}
