//
//  AdsCell.swift
//  Used.by
//
//  Created by Artsiom Korenko on 30.08.22.
//

import Foundation
import UIKit
import SnapKit


class AdsCell: UITableViewCell {

    static let key = "AdsCell"
   
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
        return label
    }()
    
    private lazy var costLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .heavy)
        label.tintColor = .myCustomPurple
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        var scroll = UIScrollView()
        scroll.backgroundColor = .clear
        scroll.layer.cornerRadius = 20
        return scroll
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var smallDescription: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.tintColor = .myCustomPurple
        label.numberOfLines = 2
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
    
    
    
    func changeTitleCell(adsInfo: AdsInfo) {
        titleCell.text = "\(adsInfo.carBrend) \(adsInfo.carModel)"
        costLabel.text = "\(adsInfo.cost) $"
    }
    
    func changeSmallDescription(adsInfo: AdsInfo) {
        let year = adsInfo.year
        var gearBox = ""
        let capacity = adsInfo.capacity
        let mileage = adsInfo.mileage
        var typeDrive = ""
        var typeEngine = ""
        var condition = ""
        let urlPhoto = adsInfo.photo
        var arrayImage: [UIImage] = []
        
        if let text = GearBox.allCases.first(where: {GearBoxStruct(rawValue: adsInfo.gearBox).contains($0.options)}) {
            gearBox = text.title
        }
        
        if let text = TypeOfDrive.allCases.first(where: {TypeOfDriveStruct(rawValue: adsInfo.typeDrive).contains($0.options)}) {
            typeDrive = text.title
        }
        
        if let text = TypeEngime.allCases.first(where: {TypeEngimeStruct(rawValue: adsInfo.typeEngine).contains($0.options)}) {
            typeEngine = text.title
        }
        
        if let text = ConditionsForAddAds.allCases.first(where: {ConditionStruct(rawValue: adsInfo.condition).contains($0.options)}) {
            condition = text.title
        }
        
        self.smallDescription.text = "\(year) year, gearbox: \(gearBox), \(capacity) cm, \(typeEngine), \(typeDrive), \(mileage) km, \(condition)"
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            urlPhoto.forEach({arrayImage.append($0.image)})
            DispatchQueue.main.async {
                arrayImage.forEach({self.stackView.addArrangedSubview(UIImageView(image: $0))})
                for image in self.stackView.arrangedSubviews {
                    image.snp.makeConstraints {
                        $0.width.height.equalTo(250)
                    }
                }
            }
        }
    }
    
// MARK: Metods for consteint
    
    private func addConstraint() {
        viewForContent.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview().inset(16)
        }
        
        titleCell.snp.makeConstraints {
            $0.top.trailing.leading.equalTo(viewForContent).inset(16)
        }
        
        costLabel.snp.makeConstraints {
            $0.trailing.leading.equalTo(viewForContent).inset(16)
            $0.top.equalTo(titleCell.snp.bottom).offset(8)
        }
    
        scrollView.snp.makeConstraints {
            $0.top.equalTo(costLabel.snp.bottom).offset(16)
            $0.trailing.leading.equalTo(viewForContent).inset(16)
            $0.height.equalTo(250)
        }
        
        stackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(scrollView)
        }
        
        smallDescription.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom).offset(16)
            $0.trailing.leading.bottom.equalTo(viewForContent).inset(16)
        }
        
    }
    
    private func addElements() {
        contentView.addSubview(viewForContent)
        viewForContent.addSubview(titleCell)
        viewForContent.addSubview(costLabel)
        scrollView.addSubview(stackView)
        viewForContent.addSubview(scrollView)
        viewForContent.addSubview(smallDescription)
    }
}
