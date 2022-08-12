//
//  ProfileCellForSettingVC.swift
//  Used.by
//
//  Created by Artsiom Korenko on 10.08.22.
//

import UIKit

class ProfileCellForSettingVC: UITableViewCell {

    private lazy var logInLabel: UILabel = {
       var label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 23, weight: .heavy)
        label.text = "Log in"
        return label
    }()
    
    private lazy var textEtentionsLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.text = "asdf"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var image: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        return imageView
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
