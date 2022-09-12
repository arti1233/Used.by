//
//  CellForDescription.swift
//  Used.by
//
//  Created by Artsiom Korenko on 28.08.22.
//

import Foundation
import UIKit
import SnapKit

class CellForDescription: UITableViewCell {

    static let key = "CellForDescription"
    
    private lazy var mainView: UIView = {
        var view = UIView()
        view.backgroundColor = .myColorForCell
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var nameCellLabel: CustomUILabel = {
        var label = CustomUILabel()
        label.text = "Description"
        return label
    }()
    
    private lazy var descriptionTextLabel: CustomUILabel = {
        var label = CustomUILabel()
        label.numberOfLines = 6
        label.font = UIFont.systemFont(ofSize: 17)
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
        addConstreint()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//MARK: Metods
    
    func changeDescription(text: String) {
        descriptionTextLabel.text = text
    }
    
//MARK: Metotds for constreint
    
    private func addConstreint() {
        
        mainView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview()
        }
        
        nameCellLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(16)
        }
        
        descriptionTextLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(nameCellLabel.snp.bottom).offset(8)
        }
    }
    
    private func addElements() {
        contentView.addSubview(mainView)
        mainView.addSubview(nameCellLabel)
        mainView.addSubview(descriptionTextLabel)
    }

}
