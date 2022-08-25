//
//  basicCellForSearchList.swift
//  Used.by
//
//  Created by Artsiom Korenko on 14.08.22.
//

import Foundation
import UIKit
import SnapKit

class CellForTouch: UITableViewCell {

    static let key = "CellForTouch"
    
    private lazy var nameCellLabel: CustomUILabel = {
        var label = CustomUILabel()
        label.text = "sdasd"
        return label
    }()
    
    private lazy var iconView: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(systemName: "circle")?.withTintColor(.myCustomPurple)
        view.tintColor = .myCustomPurple
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameCellLabel)
        contentView.addSubview(iconView)
        contentView.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        addElementsConstraint()
        super.updateConstraints()
    }
    

    func changeNameCell(name: String) {
        nameCellLabel.text = name
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        iconView.image = UIImage(systemName: selected ? "circle.fill" : "circle" )
    }
    
    func setSelectedAttribute(isSelected: Bool) {
        iconView.image = UIImage(systemName: isSelected ? "circle.fill" : "circle" )
    }
    
    
    
    private func addElementsConstraint() {
        
        nameCellLabel.snp.makeConstraints {
            $0.trailing.leading.bottom.top.equalToSuperview().inset(16)
        }
        
        iconView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(30)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    
    
    
    
}