//
//  CellForDiscription.swift
//  Used.by
//
//  Created by Artsiom Korenko on 31.08.22.
//

import Foundation
import UIKit
import SnapKit


class CellForSpecification: UITableViewCell {

    static let key = "CellForSpecification"
   
    private lazy var viewForContent: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var titleCell: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21)
        label.tintColor = .myCustomPurple
        label.text = "Specification"
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.tintColor = .myCustomPurple
        label.numberOfLines = 0
        return label
    }()
    
//MARK: Override functions
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()
        addConstraint()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
// MARK: Metods
    
    func changeDiscription(adsInfo: String) {
        descriptionLabel.text = adsInfo
    }
    
// MARK: Metods for consteint
    
    private func addConstraint() {
        viewForContent.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview().inset(16)
        }
        
        titleCell.snp.makeConstraints {
            $0.top.trailing.leading.equalTo(viewForContent).inset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.trailing.leading.bottom.equalTo(viewForContent).inset(16)
            $0.top.equalTo(titleCell.snp.bottom).offset(8)
        }
    }
    
    private func addElements() {
        contentView.addSubview(viewForContent)
        viewForContent.addSubview(titleCell)
        viewForContent.addSubview(descriptionLabel)
    }
}
