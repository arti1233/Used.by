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

class ProfileViewController: BaseViewController {

    private var loginButton: CustomButton = {
        var button = CustomButton()
        button.setTitle("Log out", for: .normal)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private var firebase: FireBaseProtocol!
    private var realmService: RealmServiceProtocol!
    private var userData = UserRealmModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginButton)
        firebase = FireBaseService()
        realmService = RealmService()
        userData = realmService.getUserData()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        addLoginButton()
    }
    
// MARK: Actions
    
        @objc private func loginButtonPressed(sender: UIButton) {
            firebase.signOutFirebase() { [weak self] result in
                guard let self = self else { return }
                if result {
                    self.realmService.addUserData(isAuthFirebase: false)
                    self.realmService.addUserData(isUserSignIn: false)
                    self.realmService.addUserData(ID: "")
                    print("\(result) log out")
                } else {
                    print("\(result) log out")
                }
            }
            GIDSignIn.sharedInstance.signOut()
            self.realmService.addUserData(isAuthFirebase: false)
            self.realmService.addUserData(isUserSignIn: false)
            self.realmService.addUserData(ID: "")
        }
    
// MARK: Metods
    private func addLoginButton() {
        
        loginButton.snp.makeConstraints {
            guard let tabBar = tabBarController?.tabBar.frame.height else { return }
            $0.bottom.equalToSuperview().inset(tabBar + 16)
            $0.centerX.equalTo(view.snp.centerX).inset(0)
            $0.height.equalTo(50)
            $0.trailing.leading.equalToSuperview().inset(16)
        }
    }
}


