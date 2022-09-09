//
//  MyAdsViewController.swift
//  Used.by
//
//  Created by Artsiom Korenko on 9.08.22.
//

import Foundation
import UIKit
import SnapKit
import RealmSwift

class MyAdsViewController: BaseViewController {
    
    private lazy var loginButton: CustomButton = {
        var button = CustomButton()
        button.setTitle("Log in...", for: .normal)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
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
    
    private var notificationToken: NotificationToken?
    private var realmServise: RealmServiceProtocol!
    private var userData = UserRealmModel()
    private var userDataResults: Results<UserRealmModel>!
    private var alamofire: RestAPIProviderProtocol!
    private var allAdsInfo: [AdsInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(loginButton)
        title = "My ads"
        realmServise = RealmService()
        alamofire = AlamofireProvider()
        userData = realmServise.getUserData()
        userDataResults = realmServise.getUsersRealmModel()
        getUserAds(userId: userData.userID)
        changeTextButton(isUserSignIn: userData.isUserSingIn)
        tableView.refreshControl = refreshControl
        
        guard let items = userDataResults.first else { return }
        notificationToken = items.observe{ [weak self] change in
            guard let self = self else { return }
            switch change {
            case .change(_, let properties):
                for property in properties {
                    if property.name == "userID" {
                        self.userData = self.realmServise.getUserData()
                        self.getUserAds(userId: self.userData.userID)
                        self.tableView.reloadData()
                    }
                }
                self.changeTextButton(isUserSignIn: self.userData.isUserSingIn)
                self.view.reloadInputViews()
            default:
                break
            }
        }
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        addLoginButton()
    }
    
    deinit {
        guard let token = notificationToken else { return }
        token.invalidate()
    }
    
    
// MARK: Actions
    @objc private func loginButtonPressed(sender: UIButton) {
        if userData.isUserSingIn {
            let vc = AddAdsVC()
            present(vc, animated: true)
        } else {
            let vc = LoginFormViewController()
            present(vc, animated: true)
     
        }
    }
    
    @objc private func rehresh(sender: UIRefreshControl) {
        userData = realmServise.getUserData()
        getUserAds(userId: userData.userID)
        tableView.reloadData()
        sender.endRefreshing()
    }
    
// MARK: Metods

    private func getUserAds(userId: String) {
        alamofire.getUserAds(id: userId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let info):
                self.getInfoAllAds(adsId: info.adsId)
            case .failure:
                self.allAdsInfo = []
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
                }
            }
        }
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    private func changeTextButton(isUserSignIn: Bool) {
        isUserSignIn ? loginButton.setTitle("Add new ads", for: .normal) : loginButton.setTitle("Log in...", for: .normal)
    }
    
    private func addLoginButton() {
        loginButton.snp.makeConstraints {
            guard let tabBar = tabBarController?.tabBar.frame.height else { return }
            $0.bottom.equalToSuperview().inset(tabBar + 16)
            $0.centerX.equalTo(view.snp.centerX).inset(0)
            $0.height.equalTo(50)
            $0.trailing.leading.equalToSuperview().inset(16)
        }
        tableView.snp.makeConstraints {
            $0.bottom.equalTo(loginButton.snp.top)
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaInsets.top)
        }
    }
}

extension MyAdsViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allAdsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AdsCell.key) as? AdsCell else { return UITableViewCell() }
        let info = allAdsInfo[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.changeTitleCell(adsInfo: info)
        cell.changeSmallDescription(adsInfo: info)
        cell.updateConstraints()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AdsVC()
        vc.adsInfo = allAdsInfo[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
