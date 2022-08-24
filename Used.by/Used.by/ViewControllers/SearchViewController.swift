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

    private var quantityAds: Int = 23424234

    private lazy var adsLabel: UILabel = {
        var label = UILabel()
        label.textColor = .myCustomPurple
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 26, weight: .heavy)
        return label
    }()
    
    private lazy var searchButton: CustomButton = {
        var button = CustomButton()
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(adsLabel)
        view.addSubview(searchButton)
        addAppName()
        adsLabel.text = "\(quantityAds) ads for the sale of used cars"
        
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    }
    
    @objc private func searchButtonPressed(sender: UIButton) {
        let VC = SearchCarListViewController()
        present(VC, animated: true)
    }

// MARK: Metods

// MARK: Metods for constreint
    
    private func addAppName() {
        
        adsLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        
        searchButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            $0.centerX.equalTo(view.snp.centerX).inset(0)
            $0.height.equalTo(50)
            $0.trailing.leading.equalToSuperview().inset(16)
        }
    }
    
}

