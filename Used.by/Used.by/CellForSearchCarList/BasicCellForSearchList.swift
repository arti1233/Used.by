//
//  basicCellForSearchList.swift
//  Used.by
//
//  Created by Artsiom Korenko on 14.08.22.
//

import Foundation
import UIKit
import SnapKit

class BasicCellForSearchList: UITableViewCell {

    static let key = "BasicCellForSearchList"
    
    private lazy var nameCellLabel: CustomUILabel = {
        var label = CustomUILabel()
        return label
    }()
    
    private lazy var iconView: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(systemName: "circle")?.withTintColor(.myCustomPurple)
        return view
    }()
    
    private lazy var dataPickerYearProduction: UIDatePicker = {
        var picker = UIDatePicker()
        return picker 
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameCellLabel)
        contentView.addSubview(iconView)
        contentView.layer.cornerRadius = 10
        nameCellLabel.text = "dsdsdsdsd"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addElementsConstraint()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }

    func changeNameCell(name: String) {
        nameCellLabel.text = name
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
