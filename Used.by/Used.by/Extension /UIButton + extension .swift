//
//  UIButton + extension .swift
//  Used.by
//
//  Created by Artsiom Korenko on 9.08.22.
//

import Foundation
import UIKit


extension UIButton {
    
    var mainButton: UIButton {
        self.backgroundColor = UIColor.myCustomPurple
        self.tintColor = .white
        self.layer.cornerRadius = 15
        return self
    }
}
