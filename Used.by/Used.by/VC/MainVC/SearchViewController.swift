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

    private lazy var adsLabel: UILabel = {
        var label = UILabel()
        label.textColor = .myCustomPurple
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 26, weight: .heavy)
        return label
    }()
    
    private lazy var searchButton: CustomButton = {
        var button = CustomButton()
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        return tableView
    }()
    
    private var showAllAdsButton: CustomButton = {
        var button = CustomButton()
        button.setTitle("Show ads", for: .normal)
        button.addTarget(self, action: #selector(showAllAdsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var alamofire: RestAPIProviderProtocol!
    private var quantityAds: Int = 23424234

//MARK: Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        alamofire = AlamofireProvider()
        addElements()
        addConsteint()
        getQuantityAds()
        title = "USED.BY"
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    }
    
//MARK: Metods
    
    private func getQuantityAds() {
        alamofire.getAllAdsId { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.quantityAds = result.id.count
                self.adsLabel.text = "\(self.quantityAds) ads for the sale of used cars"
            case .failure:
                print("Error")
            }
        }
    }
    
    @objc private func searchButtonPressed(sender: UIButton) {
        let vc = ListSearchParametrVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func showAllAdsButtonPressed(sender: UIButton) {
        let vc = ViewingAdsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
// MARK: Metods for constreint
    
    private func addConsteint() {
        
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
        
        showAllAdsButton.snp.makeConstraints {
            $0.bottom.equalTo(searchButton.snp.top).offset(-16)
            $0.centerX.equalTo(view.snp.centerX).inset(0)
            $0.height.equalTo(50)
            $0.trailing.leading.equalToSuperview().inset(16)
        }
    }
    
    private func addElements() {
        view.addSubview(adsLabel)
        view.addSubview(searchButton)
        view.addSubview(showAllAdsButton)
    }
}

