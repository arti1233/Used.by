//
//  CustomUILabel.swift
//  Used.by
//
//  Created by Artsiom Korenko on 14.08.22.
//

import Foundation
import UIKit

class CustomUILabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        textColor = .myCustomPurple
        font = UIFont.systemFont(ofSize: 21)
        textAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
