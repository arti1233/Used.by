//
//  MainTabBarController.swift
//  Used.by
//
//  Created by Artsiom Korenko on 9.08.22.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
        
        
    }
    
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: SearchViewController(), title: "Search", image: UIImage(systemName: "magnifyingglass.circle.fill")),
            generateVC(viewController: MyAdsViewController(), title: "My ads", image: UIImage(systemName: "list.bullet.rectangle")),
            generateVC(viewController: SaveAdsViewController(), title: "Save", image: UIImage(systemName: "bookmark")),
            generateVC(viewController: SettingViewController(), title: "Setting", image: UIImage(systemName: "gear"))
        ]
        
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        
        return viewController
    }
    
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let widht = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionOnX, y: tabBar.bounds.minY - positionOnY, width: widht, height: height), cornerRadius: height / 2)
        
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = widht / 4
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.mainWhite.cgColor
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
    
    
}
