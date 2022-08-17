//
//  MainTabBarController.swift
//  Used.by
//
//  Created by Artsiom Korenko on 9.08.22.
//

import Foundation
import UIKit
import SnapKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    
    private func generateTabBar() {
        
        let myAdsViewController = UINavigationController(rootViewController: MyAdsViewController())
        let saveAdsViewController = UINavigationController(rootViewController:  SaveAdsViewController())
        let settingViewController = UINavigationController(rootViewController: SettingViewController())
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
          
        viewControllers = [
            generateVC(viewController: searchViewController, title: "Search", image: UIImage(systemName: "magnifyingglass")),
            generateVC(viewController: myAdsViewController, title: "My ads", image: UIImage(systemName: "list.bullet.rectangle")),
            generateVC(viewController: saveAdsViewController, title: "Save", image: UIImage(systemName: "bookmark")),
            generateVC(viewController: settingViewController, title: "Setting", image: UIImage(systemName: "gear"))
        ]
        
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image

        return viewController
    }
    
    private func setTabBarAppearance() {
        tabBar.backgroundColor = UIColor.mainWhite
        tabBar.tintColor = .myCustomPurple
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
}
