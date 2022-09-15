//
//  File.swift
//  Used.by
//
//  Created by Artsiom Korenko on 12.08.22.
//

import Foundation
import UIKit


class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackgroundColor
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.tintColor = .myCustomPurple
        navigationBar.barTintColor = .tabBarColor
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.myCustomPurple]
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.myCustomPurple, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21, weight: .heavy)]
    }
    
    func offLargeTitle() {
        navigationItem.largeTitleDisplayMode = .never
    }
}
