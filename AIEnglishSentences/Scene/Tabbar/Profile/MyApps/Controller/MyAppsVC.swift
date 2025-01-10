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
        backgroundImageView.image =  .appImage(.backgroundImage)
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


