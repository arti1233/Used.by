//
//  SettingViewController.swift
//  Used.by
//
//  Created by Artsiom Korenko on 9.08.22.
//

import Foundation
import UIKit
import SnapKit

class SettingViewController: BaseViewController {

    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .blue
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        addTableView()
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func addTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            guard let tabBar = tabBarController?.tabBar.frame.height else { return }
            $0.bottom.equalToSuperview().inset(tabBar)
            $0.trailing.leading.equalTo(0)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(0)
        }
    }
}


extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
