//
//  UIButton + extension .swift
//  Used.by
//
//  Created by Artsiom Korenko on 9.08.22.
//

import Foundation
import UIKit


class CustomButton: UIButton {
   
    init() {
        super.init(frame: .zero)
        backgroundColor = .myCustomPurple
        layer.cornerRadius = 15
        tintColor = .white
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
