import UIKit
import SnapKit
import BaseMVVMCKit

import UIKit
import SnapKit
import BaseMVVMCKit

final class MyAppsVC: BaseViewController<MyAppsCoordinator, MyAppsViewModel> {
   
    // MARK: - Properties
    private let apps: [AppModel] = AppConstants.myApps
    
    // MARK: - UI Elements
    private var backgroundImageView: UIImageView!
    private var appBar: AppBar!
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        // Background Image
        backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        view.addSubview(backgroundImageView)
        
        // AppBar
        appBar = AppBar(type: .myApps)
        appBar.delegate = self
        view.addSubview(appBar)
        
        // TableView
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AppCell.self, forCellReuseIdentifier: "AppCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInset = .zero
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        // Background ImageView
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // AppBar
        appBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(UIHelper.statusBarHeight + UIHelper.dynamicHeight(10))
        }
        
        // TableView
        tableView.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom).offset(UIHelper.dynamicHeight(10))
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MyAppsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppCell", for: indexPath) as? AppCell else {
            return UITableViewCell()
        }
        cell.configure(with: apps[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension MyAppsVC: AppCellDelegate {
    func didTapOpen(_ app: AppModel) {
        print("Open \(app.appName)")
    }
}

extension MyAppsVC: AppBarDelegate {
    func leftButtonTapped() {
        coordinator?.back()
    }
    
    func rightButtonTapped() {}
}
struct AppModel {
    let appIcon: UIImage
    let appName: String
    let appDescription: String

}

protocol AppCellDelegate: AnyObject {
  func didTapOpen(_ app: AppModel)
}


final class AppCell: UITableViewCell {
    // MARK: - Properties
    weak var delegate: AppCellDelegate?
    private var app: AppModel?
    
    // MARK: - UI Elements
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.mainColor?.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .dynamicFont(size: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let appDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .dynamicFont(size: 14, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private let openButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Open", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mainColor
        button.titleLabel?.font = .dynamicFont(size: 12, weight: .medium)
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(UIHelper.dynamicHeight(8))
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        containerView.addSubview(appIconImageView)
        appIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIHelper.dynamicHeight(16))
            make.leading.equalToSuperview().inset(16)
            make.width.height.equalTo(UIHelper.dynamicHeight(60))
        }
        
        containerView.addSubview(appNameLabel)
        appNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(appIconImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(UIHelper.dynamicHeight(16))
        }
        
        containerView.addSubview(openButton)
        openButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(appNameLabel)
            make.width.equalTo(UIHelper.dynamicWidth(50))
            make.height.equalTo(UIHelper.dynamicHeight(20))
        }
        openButton.addTarget(self, action: #selector(openButtonTapped), for: .touchUpInside)

        containerView.addSubview(appDescriptionLabel)
        appDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(appNameLabel)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(appNameLabel.snp.bottom).offset(UIHelper.dynamicHeight(8))
            make.bottom.equalToSuperview().inset(UIHelper.dynamicHeight(16))
        }
    }
    
    @objc private func openButtonTapped() {
        guard let app = app else { return }
        delegate?.didTapOpen(app)
    }
    
    // MARK: - Configure Cell
    func configure(with app: AppModel) {
        self.app = app
        appIconImageView.image = app.appIcon
        appNameLabel.text = app.appName
        appDescriptionLabel.text = app.appDescription
    }
}
