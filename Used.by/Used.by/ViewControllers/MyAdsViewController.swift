//
//  MyAdsViewController.swift
//  Used.by
//
//  Created by Artsiom Korenko on 9.08.22.
//

import Foundation
import UIKit

class MyAdsViewController: UIViewController {

     var myButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackgroundColor
        
        myButton = UIButton(type: .roundedRect)
        myButton.frame = CGRect(x: 150, y: 150, width: 200, height: 40)
        myButton.tintColor = .purple
        myButton.setTitle("add", for: .normal)
        myButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        
        view.addSubview(myButton)
        
    }

    
    @objc func buttonPressed(sender: UIButton) {
        let LoginFoarmViewController = LoginFoarnViewController()
        present(LoginFoarmViewController, animated: true)
    }

}
