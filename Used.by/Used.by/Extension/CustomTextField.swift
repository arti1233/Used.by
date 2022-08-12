//
//  UITextField + extension.swift
//  Used.by
//
//  Created by Artsiom Korenko on 9.08.22.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    init() {
        super.init(frame: .zero)
        textColor = UIColor.myCustomPurple
        backgroundColor = .white
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
