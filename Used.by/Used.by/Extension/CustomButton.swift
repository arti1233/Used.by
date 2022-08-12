//
//  UIButton + extension .swift
//  Used.by
//
//  Created by Artsiom Korenko on 9.08.22.
//

import Foundation
import UIKit


class CustomButton: UIButton {
    
    override func `self`() -> Self {
        self.backgroundColor = UIColor.myCustomPurple
        self.layer.cornerRadius = 15
        self.tintColor = .white
        return self
    }
}
