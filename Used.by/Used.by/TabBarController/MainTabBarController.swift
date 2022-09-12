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
        
        let saveAdsViewController = UINavigationController(rootViewController:  SaveAdsViewController())
        let settingViewController = UINavigationController(rootViewController: ProfileViewController())
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
          
        viewControllers = [
            generateVC(viewController: searchViewController, title: "Search", image: UIImage(systemName: "magnifyingglass")),
            generateVC(viewController: saveAdsViewController, title: "Save", image: UIImage(systemName: "bookmark")),
            generateVC(viewController: settingViewController, title: "Profile", image: UIImage(systemName: "person.fill"))
        ]
        
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image

        return viewController
    }
    
    private func setTabBarAppearance() {
        tabBar.backgroundColor = .tabBarColor
        tabBar.tintColor = .tabBarItemLight
        tabBar.unselectedItemTintColor = .lightGray
    }
}
