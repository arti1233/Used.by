//
//  SaveAdsViewController .swift
//  Used.by
//
//  Created by Artsiom Korenko on 9.08.22.
//

import Foundation
import UIKit
import SnapKit
import RealmSwift

class SaveAdsViewController: BaseViewController {
    
    private var loginButton: CustomButton = {
        var button = CustomButton()
        button.setTitle("Log in...", for: .normal)
        button.backgroundColor = .logInColor
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var spinerView: UIActivityIndicatorView = {
        var spiner = UIActivityIndicatorView()
        spiner.hidesWhenStopped = true
        return spiner
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .purple
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AdsCell.self, forCellReuseIdentifier: AdsCell.key)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(rehresh(sender:)), for: .valueChanged)
        return refresh
    }()
    
    //Realm objects
    private var notificationToken: NotificationToken?
    private var realmServise: RealmServiceProtocol!
    private var userData = UserRealmModel()
    private var userDataResults: Results<UserRealmModel>!
    //Alamofire
    private var alamofire: RestAPIProviderProtocol!
    
    private var allAdsInfo: [AdsInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addElements()
        realmServise = RealmService()
        alamofire = AlamofireProvider()
        userData = realmServise.getUserData()
        userDataResults = realmServise.getUsersRealmModel()
        showLoginButton(isShow: userData.isUserSingIn)
        getSaveUserAds(userId: userData.userID)
        
        title = "Save ads"
        
        // Notification token
        guard let items = userDataResults.first else { return }
        notificationToken = items.observe{ [weak self] change in
            guard let self = self else { return }
            switch change {
            case .change(_, let properties):
                for property in properties {
                    if property.name == "userID" {
                        self.allAdsInfo = []
                        self.userData = self.realmServise.getUserData()
                        self.getSaveUserAds(userId: self.userData.userID)
                        self.tableView.reloadData()
                    }
                }
                self.showLoginButton(isShow: self.userData.isUserSingIn)
                self.view.reloadInputViews()
            default:
                break
            }
        }
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        addConstreint()
    }
    
    deinit {
        guard let token = notificationToken else { return }
        token.invalidate()
    }
    
// MARK: Actions
    @objc private func loginButtonPressed(sender: UIButton) {
        let LoginFoarmViewController = LoginFormViewController()
        present(LoginFoarmViewController, animated: true)
    }
    
    @objc private func rehresh(sender: UIRefreshControl) {
        userData = realmServise.getUserData()
        getSaveUserAds(userId: userData.userID)
        tableView.reloadData()
        sender.endRefreshing()
    }
    
// MARK: Metods
    
    private func getSaveUserAds(userId: String) {
        alamofire.getSaveUserAds(id: userId) { [weak self] result in
            guard let self = self else { return }
            self.spinerView.startAnimating()
            switch result {
            case .success(let info):
                self.getInfoAllAds(adsId: info.saveAds)
            case .failure:
                self.allAdsInfo = []
                self.spinerView.stopAnimating()
            }
        }
    }
    
    private func getInfoAllAds(adsId: [String]) {
        allAdsInfo = []
        let group = DispatchGroup()
        for id in adsId {
            group.enter()
            alamofire.getAdsInfo(id: id) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    self.allAdsInfo.append(value)
                    group.leave()
                case .failure:
                    self.allAdsInfo = []
                    self.spinerView.stopAnimating()
                }
            }
        }
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.spinerView.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    private func showLoginButton(isShow: Bool) {
        loginButton.isHidden = isShow
    }

//MARK: Metods for constreint
    private func addConstreint() {
        tableView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaInsets.top)
        }
        
        loginButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            $0.centerX.equalTo(view.snp.centerX).inset(0)
            $0.height.equalTo(50)
            $0.trailing.leading.equalToSuperview().inset(16)
        }
        
        spinerView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaInsets.top)
        }
    }
    
    private func addElements() {
        view.addSubview(tableView)
        view.addSubview(loginButton)
        view.addSubview(spinerView)
        tableView.refreshControl = refreshControl
    }
}

extension SaveAdsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allAdsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AdsCell.key) as? AdsCell,
              !allAdsInfo.isEmpty  else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.changeSmallDescription(adsInfo: allAdsInfo[indexPath.row])
        cell.updateConstraints()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AdsVC()
        let info = allAdsInfo[indexPath.row]
        vc.adsInfo = info
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
        
}
