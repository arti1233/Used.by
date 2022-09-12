//
//  CellForUserInfo.swift
//  Used.by
//
//  Created by Artsiom Korenko on 10.09.22.
//

import Foundation
import SnapKit
import UIKit


class CellForUserInfo: UITableViewCell {
    
    static let key = "CellForUserInfo"
    
    private lazy var mainView: UIView = {
        var view = UIView()
        view.backgroundColor = .myColorForCell
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var nameUser: UILabel = {
        var label = UILabel()
        label.textColor = .myCustomPurple
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        return label
    }()
    
    private lazy var emailUser: CustomUILabel = {
        var label = CustomUILabel()
        return label
    }()

//MARK: Override functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        addConstreint()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        emailUser.text = ""
        nameUser.text = "" 
    }

//MARK: Metods
    func changeName(name: String, email: String) {
        nameUser.text = name
        emailUser.text = email
    }
    
//MARK: Metods for Constreint
    private func addConstreint() {
        mainView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(8)
        }
        
        emailUser.snp.makeConstraints {
            $0.centerX.equalTo(mainView.snp.centerX)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        nameUser.snp.makeConstraints {
            $0.bottom.equalTo(emailUser.snp.top)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(16)
        }
    }
    
    private func addElements() {
        contentView.addSubview(mainView)
        mainView.addSubview(nameUser)
        mainView.addSubview(emailUser)
    }
}
