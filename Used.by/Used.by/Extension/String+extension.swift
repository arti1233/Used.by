//
//  String+extension.swift
//  Used.by
//
//  Created by Artsiom Korenko on 6.09.22.
//

import Foundation
import UIKit

// запрос для получения картинки
extension String {
    var image: UIImage {
        guard let apiURL = URL(string: self) else { return UIImage() }
        let data = try! Data(contentsOf: apiURL)
        guard let image = UIImage(data: data) else { return UIImage() }
        return image
    }
    
    var localize: String {
        return NSLocalizedString(self, comment: "")
    }
}
