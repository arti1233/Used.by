//
//  ViewController.swift
//  Used.by
//
//  Created by Artsiom Korenko on 9.08.22.
//

import Foundation
import UIKit
import SnapKit

class SearchViewController: BaseViewController {

    private lazy var appName: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.myCustomPurple
        label.textAlignment = .center
        label.text = "USED.BY"
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(appName)
        
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        addAppName()
        
    }
    
    
    
    
// MARK: Metods for constreint
    
    private func addAppName() {
        appName.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            $0.height.equalTo(40)
        }
    }
}

