//
//  MyAdsViewController.swift
//  Used.by
//
//  Created by Artsiom Korenko on 9.08.22.
//

import Foundation
import UIKit
import SnapKit

class MyAdsViewController: BaseViewController {
    
    private lazy var loginButton: CustomButton = {
        var button = CustomButton()
        button.setTitle("Log in...", for: .normal)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginButton)
        

    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        addLoginButton()
    }
    
// MARK: Actions
    @objc private func loginButtonPressed(sender: UIButton) {
        let LoginFoarmViewController = LoginFormViewController()
        present(LoginFoarmViewController, animated: true)
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
