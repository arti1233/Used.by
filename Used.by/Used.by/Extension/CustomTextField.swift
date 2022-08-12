//
//  UITextField + extension.swift
//  Used.by
//
//  Created by Artsiom Korenko on 9.08.22.
//

import Foundation
import UIKit

class CustomTextField: UITextField {

    override func `self`() -> Self {
        self.textColor = UIColor.myCustomPurple
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        return self
    }

}
