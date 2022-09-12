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
    
    private lazy var searchButton: CustomButton = {
        var button = CustomButton()
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AdsCell.self, forCellReuseIdentifier: AdsCell.key)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(rehresh(sender:)), for: .valueChanged)
        return refresh
    }()
    
    private lazy var spinerView: UIActivityIndicatorView = {
        var spiner = UIActivityIndicatorView()
        spiner.hidesWhenStopped = true
        return spiner
    }()
    
    var alamofireServise: RestAPIProviderProtocol!
    private var allAdsInfo: [AdsInfo] = []

//MARK: Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        alamofireServise = AlamofireProvider()
        addElements()
        addConsteint()
        title = "USED.BY"
        tableView.refreshControl = refreshControl
        getAllAdsId()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    }
    
    @objc private func rehresh(sender: UIRefreshControl) {
        allAdsInfo = []
        getAllAdsId()
    }
    
//MARK: Metods
 
    // Tap to search Button
    @objc private func searchButtonPressed(sender: UIButton) {
        let vc = ListSearchParametrVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Previosly I get all ads id
    private func getAllAdsId() {
        alamofireServise.getAllAdsId { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.getInfoAllAds(adsId: value.id)
            case .failure:
                print("No ok")
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    // I get information on asd 
    private func getInfoAllAds(adsId: [String]) {
        let group = DispatchGroup()
        spinerView.startAnimating()
        for id in adsId {
            group.enter()
            alamofireServise.getAdsInfo(id: id) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    self.allAdsInfo.append(value)
                    group.leave()
                case .failure:
                    print("No ok po id")
                    self.refreshControl.endRefreshing()
                }
            }
        }
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
            self.spinerView.stopAnimating()
        }
    }
    
// MARK: Metods for constreint
    
    private func addConsteint() {
        
        tableView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaInsets.top)
        }
        
        searchButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            $0.centerX.equalTo(view.snp.centerX).inset(0)
            $0.height.equalTo(50)
            $0.trailing.leading.equalToSuperview().inset(16)
        }
        
        spinerView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaInsets.top)
        }
    }
    
    private func addElements() {
        view.addSubview(tableView)
        view.addSubview(searchButton)
        view.addSubview(spinerView)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allAdsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AdsCell.key) as? AdsCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.changeSmallDescription(adsInfo: allAdsInfo[indexPath.row])
        cell.updateConstraints()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AdsVC()
        let info = allAdsInfo[indexPath.row]
        vc.adsInfo = info
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
