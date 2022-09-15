//
//  SettingViewController.swift
//  Used.by
//
//  Created by Artsiom Korenko on 9.08.22.
//

import Foundation
import UIKit
import SnapKit
import RealmSwift
import GoogleSignInSwift
import GoogleSignIn

// Enum for help made table view
enum ProfileSection: CaseIterable {
    case profile
    case ads

    var title: String {
        switch self {
        case .profile:
            return "Profile"
        case .ads:
            return "My ads"
        }
    }
}

class ProfileViewController: BaseViewController {

    private var loginButton: CustomButton = {
        var button = CustomButton()
        button.setTitle("Log out", for: .normal)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .purple
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AdsCell.self, forCellReuseIdentifier: AdsCell.key)
        tableView.register(CellForUserInfo.self, forCellReuseIdentifier: CellForUserInfo.key)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(rehresh(sender:)), for: .valueChanged)
        return refresh
    }()
    
    private lazy var spinerView: UIActivityIndicatorView = {
        var spiner = UIActivityIndicatorView()
        spiner.hidesWhenStopped = true
        return spiner
    }()
    
    //Realm object
    private var notificationToken: NotificationToken?
    private var realmServise: RealmServiceProtocol!
    private var userDataResults: Results<UserRealmModel>!
    private var userData = UserRealmModel()
    private var userInfo: Users!
    //Firebase
    private var firebase: FireBaseProtocol!
    //Alamofire
    private var alamofire: RestAPIProviderProtocol!
    private var allAdsInfo: [AdsInfo] = []
    private var nameUser = "Please log in apps"
    private var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(addAds(sender:)))]
        addElements()
        offLargeTitle()
        firebase = FireBaseService()
        realmServise = RealmService()
        alamofire = AlamofireProvider()
        userData = realmServise.getUserData()
        userDataResults = realmServise.getUsersRealmModel()
        getUserInfo(userId: userData.userID)
        changeTextButton(isUserSignIn: userData.isUserSingIn)
        title = "Profile"
    
        //Notificationt token
        guard let items = userDataResults.first else { return }
        notificationToken = items.observe{ [weak self] change in
            guard let self = self else { return }
            switch change {
            case .change(_, let properties):
                for property in properties {
                    if property.name == "userID" {
                        self.allAdsInfo = []
                        self.userData = self.realmServise.getUserData()
                        self.getUserInfo(userId: self.userData.userID)
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
        addConstreint()
    }
    
    deinit {
        guard let token = notificationToken else { return }
        token.invalidate()
    }
    
// MARK: Actions
    
    @objc private func addAds(sender: UIBarButtonItem) {
        if userData.isUserSingIn {
            let vc = AddAdsVC()
            present(vc, animated: true)
        } else {
            showAlertController(textError: "Login in your account")
        }
        
    }
    
    @objc private func loginButtonPressed(sender: UIButton) {
        if userData.isUserSingIn {
            GIDSignIn.sharedInstance.signOut()
            firebase.signOutFirebase() { [weak self] result in
                guard let self = self else { return }
                if result {
                    self.realmServise.addUserData(isUserSignIn: false)
                    self.realmServise.addUserData(ID: "")
                }
            }
        } else {
            let vc = LoginFormViewController()
            present(vc, animated: true)
        }
    }
    
    @objc private func rehresh(sender: UIRefreshControl) {
        userData = realmServise.getUserData()
        if userData.isUserSingIn  {
            getUserInfo(userId: userData.userID)
        } else {
            sender.endRefreshing()
        }
    }
    
    private func changeTextButton(isUserSignIn: Bool) {
        loginButton.setTitle( isUserSignIn ? "Log out" : "Log in...", for: .normal)
        loginButton.backgroundColor = isUserSignIn ? .myCustomPurple :  .logInColor
    }
    
// MARK: AlertController
    private func showAlertController(textError: String) {
        let alertController = UIAlertController(title: "Please", message: textError, preferredStyle: .alert)
        let closeButton = UIAlertAction(title: "Close", style: .cancel)
        
        alertController.addAction(closeButton)
        present(alertController, animated: true)
    }
    
// MARK: Metods
    
    private func getUserInfo(userId: String) {
        spinerView.startAnimating()
        alamofire.getUserInfo(id: userId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.userInfo = result
                self.nameUser = result.name
                self.email = result.email
                self.getUserAds(userId: userId)
            case .failure:
                self.nameUser = "Please log in apps"
                self.email = ""
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
                self.spinerView.stopAnimating()
            }
        }
    }
    
    private func getUserAds(userId: String) {
        alamofire.getUserAds(id: userId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let info):
                self.getInfoAllAds(adsId: info.adsId)
            case .failure:
                self.allAdsInfo = []
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
                self.spinerView.stopAnimating()
            }
        }
    }
    
    private func getInfoAllAds(adsId: [String]) {
        allAdsInfo = []
        let group = DispatchGroup()
        spinerView.startAnimating()
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
                    self.refreshControl.endRefreshing()
                    self.spinerView.stopAnimating()
                }
            }
        }
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.spinerView.stopAnimating()
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    private func addConstreint() {
        tableView.snp.makeConstraints {
            $0.bottom.equalTo(loginButton.snp.top)
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

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        ProfileSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ProfileSection.allCases[section] {
        case .profile:
            return 1
        case .ads:
            return allAdsInfo.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AdsCell.key) as? AdsCell,
              let cellProfile = tableView.dequeueReusableCell(withIdentifier: CellForUserInfo.key) as? CellForUserInfo else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.updateConstraints()
        cellProfile.selectionStyle = .none
        cellProfile.backgroundColor = .clear
        cellProfile.updateConstraints()
    
        switch ProfileSection.allCases[indexPath.section] {
        case .profile:
            cellProfile.changeName(name: nameUser, email: email)
            return cellProfile
        case .ads:
            cell.changeSmallDescription(adsInfo: allAdsInfo[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch ProfileSection.allCases[indexPath.section] {
        case .ads:
            let vc = AdsVC()
            vc.isUserAds = true
            vc.adsInfo = allAdsInfo[indexPath.row]
            vc.modalPresentationStyle = .overFullScreen
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
