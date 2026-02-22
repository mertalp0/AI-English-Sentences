//
//  PaywallViewController.swift
//  AIEnglishSentences
//

import UIKit
import SnapKit
import RevenueCat
import BaseMVVMCKit

final class PaywallViewController: UIViewController {

    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    func startLoading() {
        loadingIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func stopLoading() {
        loadingIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }

    // MARK: - UI Elements
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .systemGray4
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return button
    }()

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let crownView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlur
        view.layer.cornerRadius = 35
        
        let icon = UIImageView()
        icon.image = UIImage(systemName: "crown.fill")
        icon.tintColor = .mainColor
        icon.contentMode = .scaleAspectFit
        
        view.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(40)
        }
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localized(for: .paywallTitle)
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "d MMM yyyy"
        let prefix = String.localized(for: .paywallDatePrefix)
        label.text = String(format: prefix, formatter.string(from: Date()))
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()

    private let featureStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()

    private let packageStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()

    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .mainColor
        button.setTitle(.localized(for: .paywallActionButton), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(didTapSubscribe), for: .touchUpInside)
        
        // Gradient shadow
        button.layer.shadowColor = UIColor.mainColor?.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 8
        button.layer.shadowOpacity = 0.3
        
        return button
    }()

    private let disclaimerLabel: UILabel = {
        let label = UILabel()
        label.text = .localized(for: .paywallDisclaimer)
        label.font = .systemFont(ofSize: 11)
        label.textColor = .systemGray2
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let footerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Properties
    private let offering: Offering
    private var selectedPackage: Package?
    private var packageViews: [PackageItemView] = []

    // MARK: - Lifecycle
    init(offering: Offering) {
        self.offering = offering
        super.init(nibName: nil, bundle: nil)
        self.selectedPackage = offering.sixMonth ?? offering.threeMonth ?? offering.monthly // Default to sixMonth
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupFeatures()
        setupPackages()
        setupFooter()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(closeButton)
        view.addSubview(scrollView)
        view.addSubview(loadingIndicator)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(crownView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(featureStackView)
        contentView.addSubview(packageStackView)
        contentView.addSubview(actionButton)
        contentView.addSubview(disclaimerLabel)
        contentView.addSubview(footerLabel)

        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(32)
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }

        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }

        crownView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(70)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(crownView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
        }

        featureStackView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(32)
        }

        packageStackView.snp.makeConstraints { make in
            make.top.equalTo(featureStackView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(24)
        }

        actionButton.snp.makeConstraints { make in
            make.top.equalTo(packageStackView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(70)
        }

        disclaimerLabel.snp.makeConstraints { make in
            make.top.equalTo(actionButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
        }

        footerLabel.snp.makeConstraints { make in
            make.top.equalTo(disclaimerLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(32)
        }
    }

    private func setupFeatures() {
        let features = [
            String.localized(for: .paywallFeature1),
            String.localized(for: .paywallFeature2),
            String.localized(for: .paywallFeature3)
        ]
        
        for feature in features {
            let row = createFeatureRow(text: feature)
            featureStackView.addArrangedSubview(row)
        }
    }
    private func createFeatureRow(text: String) -> UIView {
        let container = UIView()
        
        let checkIcon = UIImageView()
        checkIcon.image = UIImage(systemName: "checkmark.circle.fill")
        checkIcon.tintColor = UIColor(red: 0.3, green: 0.8, blue: 0.5, alpha: 1.0)
        checkIcon.contentMode = .scaleAspectFit
        
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .darkGray
        
        container.addSubview(checkIcon)
        container.addSubview(label)
        
        checkIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(checkIcon.snp.trailing).offset(12)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(4)
        }
        
        return container
    }

    private func setupPackages() {
        // Clear existing
        packageStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        packageViews.removeAll()

        let packages = offering.availablePackages
        let monthlyPackage = packages.first(where: { $0.packageType == .monthly })
        let monthlyPrice = monthlyPackage?.storeProduct.price
        
        for package in packages {
            // Only show Monthly, 3-Month, and 6-Month
            guard package.packageType == .monthly ||
                  package.packageType == .threeMonth ||
                  package.packageType == .sixMonth else { continue }
                  
            let pkgView = PackageItemView(package: package, monthlyPrice: monthlyPrice)
            pkgView.isSelected = (package == selectedPackage)
            pkgView.delegate = self
            packageStackView.addArrangedSubview(pkgView)
            packageViews.append(pkgView)
        }
        
        updateActionButtonPrice()
    }

    private func setupFooter() {
        let restoreText = String.localized(for: .paywallRestore)
        let privacyText = String.localized(for: .paywallPrivacy)
        let termsText = String.localized(for: .paywallTerms)
        
        let footerText = NSMutableAttributedString()
        
        let restoreAttr: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12, weight: .medium),
            .foregroundColor: UIColor.systemGray,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        let dotAttr: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12, weight: .bold),
            .foregroundColor: UIColor.systemGray2
        ]
        
        footerText.append(NSAttributedString(string: restoreText, attributes: restoreAttr))
        footerText.append(NSAttributedString(string: "  •  ", attributes: dotAttr))
        footerText.append(NSAttributedString(string: privacyText, attributes: restoreAttr))
        footerText.append(NSAttributedString(string: "  •  ", attributes: dotAttr))
        footerText.append(NSAttributedString(string: termsText, attributes: restoreAttr))
        
        footerLabel.attributedText = footerText
        footerLabel.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapFooter(_:)))
        footerLabel.addGestureRecognizer(tap)
    }

    private func updateActionButtonPrice() {
        guard let package = selectedPackage else { return }
        let price = package.localizedPriceString
        let period: String
        switch package.packageType {
        case .sixMonth: period = .localized(for: .paywallPerSixMonth)
        case .threeMonth: period = .localized(for: .paywallPerThreeMonth)
        case .monthly: period = .localized(for: .paywallPerMonth)
        default: period = ""
        }
        
        let actionTitle = String.localized(for: .paywallActionButton)
        let title = "\(actionTitle)\n\(price) \(period)"
        let attr = NSMutableAttributedString(string: title)
        
        let fullRange = NSRange(location: 0, length: title.count)
        attr.addAttribute(.foregroundColor, value: UIColor.white, range: fullRange)
        
        let startRange = (title as NSString).range(of: actionTitle)
        attr.addAttribute(.font, value: UIFont.systemFont(ofSize: 18, weight: .bold), range: startRange)
        
        let pricePart = "\(price) \(period)"
        let priceRange = (title as NSString).range(of: pricePart)
        attr.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .medium), range: priceRange)
        
        actionButton.setAttributedTitle(attr, for: .normal)
        actionButton.titleLabel?.numberOfLines = 2
        actionButton.titleLabel?.textAlignment = .center
    }

    // MARK: - Actions
    @objc private func didTapClose() {
        dismiss(animated: true)
    }

    @objc private func didTapSubscribe() {
        guard let package = selectedPackage else { return }
        startLoading()
        SubscriptionService.shared.purchase(package: package) { [weak self] isPremium in
            self?.stopLoading()
            if isPremium {
                self?.dismiss(animated: true)
            }
        }
    }

    @objc private func didTapFooter(_ gesture: UITapGestureRecognizer) {
        let text = footerLabel.text ?? ""
        let restoreText = String.localized(for: .paywallRestore)
        let privacyText = String.localized(for: .paywallPrivacy)
        let termsText = String.localized(for: .paywallTerms)
        
        let restoreRange = (text as NSString).range(of: restoreText)
        let privacyRange = (text as NSString).range(of: privacyText)
        let termsRange = (text as NSString).range(of: termsText)
        
        if gesture.didTapAttributedTextInLabel(label: footerLabel, inRange: restoreRange) {
            restorePurchases()
        } else if gesture.didTapAttributedTextInLabel(label: footerLabel, inRange: privacyRange) {
            openURL(AppConstants.URLs.privacyPolicyURL)
        } else if gesture.didTapAttributedTextInLabel(label: footerLabel, inRange: termsRange) {
            openURL(AppConstants.URLs.termsOfUseURL)
        }
    }

    private func restorePurchases() {
        startLoading()
        SubscriptionService.shared.restorePurchase { [weak self] isPremium in
            self?.stopLoading()
            if isPremium {
                self?.dismiss(animated: true)
            } else {
                let alert = UIAlertController(
                    title: .localized(for: .paywallAlertTitle),
                    message: .localized(for: .paywallAlertNoSubscription),
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: .localized(for: .paywallAlertOk), style: .default))
                self?.present(alert, animated: true)
            }
        }
    }

    private func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - PackageItemViewDelegate
extension PaywallViewController: PackageItemViewDelegate {
    func didSelectPackage(_ package: Package) {
        self.selectedPackage = package
        for view in packageViews {
            view.isSelected = (view.package == package)
        }
        updateActionButtonPrice()
    }
}

// MARK: - PackageItemView
protocol PackageItemViewDelegate: AnyObject {
    func didSelectPackage(_ package: Package)
}

final class PackageItemView: UIView {
    let package: Package
    let monthlyPrice: Decimal?
    weak var delegate: PackageItemViewDelegate?

    var isSelected: Bool = false {
        didSet {
            updateSelectionState()
        }
    }

    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let monthlyEquivalentLabel = UILabel()
    private let radioIcon = UIImageView()
    private let badgeLabel = UILabel()

    init(package: Package, monthlyPrice: Decimal?) {
        self.package = package
        self.monthlyPrice = monthlyPrice
        super.init(frame: .zero)
        setupUI()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(monthlyEquivalentLabel)
        containerView.addSubview(radioIcon)
        containerView.addSubview(badgeLabel)

        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemGray5.cgColor
        containerView.clipsToBounds = true

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(80)
        }

        radioIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
        }

        badgeLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.centerY.equalTo(titleLabel)
            make.height.equalTo(20)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }

        monthlyEquivalentLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(16)
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tap)
    }

    private func configure() {
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        priceLabel.font = .systemFont(ofSize: 14, weight: .medium)
        priceLabel.textColor = .systemGray
        monthlyEquivalentLabel.font = .systemFont(ofSize: 14, weight: .bold)
        monthlyEquivalentLabel.textColor = .mainColor

        switch package.packageType {
        case .sixMonth:
            titleLabel.text = .localized(for: .paywallPackageSixMonth)
            let period = String.localized(for: .paywallPerSixMonth)
            priceLabel.text = "\(package.localizedPriceString) \(period)"
            badgeLabel.isHidden = false
            monthlyEquivalentLabel.isHidden = false

            let months: Decimal = 6
            let mPrice = package.storeProduct.price / months
            let mPeriod = String.localized(for: .paywallPerMonth)
            monthlyEquivalentLabel.text = "→ \(formatPrice(mPrice)) \(mPeriod)"

            if let baseMonthly = monthlyPrice, baseMonthly > 0 {
                let totalMonthlyCost = baseMonthly * months
                let savings = ((totalMonthlyCost - package.storeProduct.price) / totalMonthlyCost) * 100
                let savingsTemplate = String.localized(for: .paywallSavings)
                let roundedSavings = (savings as NSDecimalNumber).doubleValue.rounded()
                badgeLabel.text = " \(String(format: savingsTemplate, Int(roundedSavings))) "
            } else {
                badgeLabel.text = " \(String.localized(for: .paywallBestValue)) "
            }

        case .threeMonth:
            titleLabel.text = .localized(for: .paywallPackageThreeMonth)
            let period = String.localized(for: .paywallPerThreeMonth)
            priceLabel.text = "\(package.localizedPriceString) \(period)"
            badgeLabel.isHidden = false
            monthlyEquivalentLabel.isHidden = false
            
            let months: Decimal = 3
            let mPrice = package.storeProduct.price / months
            let mPeriod = String.localized(for: .paywallPerMonth)
            monthlyEquivalentLabel.text = "→ \(formatPrice(mPrice)) \(mPeriod)"
            
            if let baseMonthly = monthlyPrice, baseMonthly > 0 {
                let totalMonthlyCost = baseMonthly * months
                let savings = ((totalMonthlyCost - package.storeProduct.price) / totalMonthlyCost) * 100
                let savingsTemplate = String.localized(for: .paywallSavings)
                let roundedSavings = (savings as NSDecimalNumber).doubleValue.rounded()
                badgeLabel.text = " \(String(format: savingsTemplate, Int(roundedSavings))) "
            } else {
                badgeLabel.isHidden = true
            }

        case .monthly:
            titleLabel.text = .localized(for: .paywallPackageMonthly)
            badgeLabel.isHidden = true
            let period = String.localized(for: .paywallPerMonth)
            priceLabel.text = "\(package.localizedPriceString) \(period)"
            monthlyEquivalentLabel.isHidden = true
            
            // Adjust constraints for centered feel
            priceLabel.snp.remakeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(8)
                make.leading.equalToSuperview().offset(16)
                make.bottom.equalToSuperview().inset(16)
            }
            
        default:
            titleLabel.text = "Premium"
            badgeLabel.isHidden = true
            priceLabel.text = package.localizedPriceString
        }
        
        badgeLabel.backgroundColor = .mainBlur
        badgeLabel.textColor = .mainColor
        badgeLabel.font = .systemFont(ofSize: 10, weight: .bold)
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.clipsToBounds = true
    }

    private func formatPrice(_ price: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = package.storeProduct.priceFormatter?.locale
        return formatter.string(from: NSDecimalNumber(decimal: price)) ?? ""
    }

    private func updateSelectionState() {
        if isSelected {
            containerView.layer.borderColor = UIColor.mainColor?.cgColor
            containerView.backgroundColor = .mainBlur
            radioIcon.image = UIImage(systemName: "checkmark.circle.fill")
            radioIcon.tintColor = .mainColor
        } else {
            containerView.layer.borderColor = UIColor.systemGray5.cgColor
            containerView.backgroundColor = .white
            radioIcon.image = UIImage(systemName: "circle")
            radioIcon.tintColor = .systemGray4
        }
    }

    @objc private func didTap() {
        delegate?.didSelectPackage(package)
    }
}

// MARK: - Extension for UIGestureRecognizer
extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        guard let attrString = label.attributedText else { return false }
        
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: .zero)
        let textStorage = NSTextStorage(attributedString: attrString)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
