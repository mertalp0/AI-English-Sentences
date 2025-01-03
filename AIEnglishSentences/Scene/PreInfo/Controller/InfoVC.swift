//
//  InfoVC.swift
//  AIEnglishSentences
//
//  Created by mert alp on 15.12.2024.
//

import UIKit
import BaseMVVMCKit
import SnapKit

final class InfoVC: BaseViewController<InfoCoordinator, InfoViewModel> {
    
    // MARK: - UI Elements
    private var backgroundImageView: UIImageView!
    private var logoImageView: UIImageView!
    private var subtitleLabel: UILabel!
    private var loginButton: AuthButton!
    private var socialButtonsView: SocialButtonsView!
    private var socialButtonsViewModel: SocialButtonsViewModel!

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        // Background Image
        backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        view.addSubview(backgroundImageView)
        
        // Logo Image
        logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "AiLex")
        logoImageView.contentMode = .scaleAspectFit
        view.addSubview(logoImageView)
        
        // Subtitle Label
        subtitleLabel = UILabel()
        subtitleLabel.text = "Create. Listen. Inspire.\nAiLex makes words come alive."
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = UIColor.darkGray
        subtitleLabel.attributedText = NSAttributedString(
            string: "Create. Listen. Inspire.\nAiLex makes words come alive.",
            attributes: [
                .font: UIFont.systemFont(ofSize: 22, weight: .bold),
                .foregroundColor: UIColor.darkGray,
                .kern: 1.0,
                .paragraphStyle: {
                    let style = NSMutableParagraphStyle()
                    style.lineSpacing = 5
                    style.alignment = .center
                    return style
                }()
            ]
        )
        view.addSubview(subtitleLabel)
        
        // Login Button
        loginButton = AuthButton(type: .normal)
        loginButton.delegate = self
        view.addSubview(loginButton)
        
    
         socialButtonsViewModel = SocialButtonsViewModel(
            actionText: "You don’t have an account?",
            actionHighlightedText: "Sign up",
            googleButtonTitle: "Continue with Google",
            appleButtonTitle: "Continue with Apple"
        )
        
        socialButtonsViewModel.onGoogleButtonTapped = {
            self.viewModel.googleSignIn(from: self) {  [weak self] isSuccess in
                if isSuccess {
                    self?.coordinator?.showDashboard()
                }
            }
        }
        
        socialButtonsViewModel.onAppleButtonTapped = {
            self.viewModel.signInWithApple(presentationAnchor: self.view.window!) { [weak self] isSuccess in
                if isSuccess {
                    self?.coordinator?.showDashboard()
                }
            }
        }
        
        socialButtonsViewModel.onActionLabelTapped = {
            self.coordinator?.showRegister()
        }
        
        socialButtonsView = SocialButtonsView(viewModel: socialButtonsViewModel)
        view.addSubview(socialButtonsView)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
    
        // Background ImageView
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Logo ImageView
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(90)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(80)
        }
        
        // Subtitle Label
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        // Login Button
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(socialButtonsView.snp.top).offset(-20)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(50)
        }
        
        socialButtonsView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.trailing.equalToSuperview()
        }
    }
    
      // MARK: - Actions
      @objc private func didTapSignUp() {
          print("Sign up tapped")
      }
}

// MARK: - AuthButtonDelegate
extension InfoVC: AuthButtonDelegate {
    func didTapButton(type: AuthButtonType) {
        switch type {
        case .normal:
            coordinator?.showLogin()
        case .google:
            print("Google login tapped")
        case .apple:
            print("Apple login tapped")
        }
    }
}
