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
        scroll.layer.cornerRadius = 10
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
    
    private lazy var spinerView: UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView()
        spiner.backgroundColor = .mainBackgroundColor
        spiner.hidesWhenStopped = true
        return spiner
    }()

    var complition: (([UIImage]) -> Void)?
    var isTransitionOnLookPhoto = false
    var isSmallCell = true
    var arrayImage: [UIImage] = []
    
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
        addConstraint(isSmallCell: isSmallCell)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
//MARK: Actions
    
    @objc private func tapOnStackViewPressed(_ sender: UITapGestureRecognizer) {
        if isTransitionOnLookPhoto {
            print("OK")
            guard let complition = complition else { return }
            complition(arrayImage)
        }
    }

// MARK: Metods
    
    func changeSmallDescription(adsInfo: AdsInfo) {
        spinerView.startAnimating()
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
        
        smallDescription.text = "\(year) year, gearbox: \(gearBox), \(capacity) l, \(typeEngine), \(typeDrive), \(mileage) km, \(condition)"
        titleCell.text = "\(adsInfo.carBrend) \(adsInfo.carModel)"
        costLabel.text = "\(adsInfo.cost) $"
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            urlPhoto.forEach({arrayImage.append($0.image)})
            self.arrayImage = arrayImage
            DispatchQueue.main.async {
                arrayImage.forEach({self.stackView.addArrangedSubview(UIImageView(image: $0))})
                for image in self.stackView.arrangedSubviews {
                    image.contentMode = .scaleAspectFill
                    image.snp.makeConstraints {
                        $0.height.equalTo(self.scrollView.frame.height)
                        if self.isSmallCell {
                            $0.width.equalTo(self.scrollView.frame.height)
                        } else {
                            $0.width.equalTo(self.viewForContent.frame.width - 32)
                        }
                    }
                }
                self.spinerView.stopAnimating()
            }
        }
    }
    
// MARK: Metods for consteint
    
    private func addConstraint(isSmallCell: Bool) {
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
    
        if isSmallCell {
            scrollView.snp.makeConstraints {
                $0.top.equalTo(costLabel.snp.bottom).offset(16)
                $0.trailing.leading.equalTo(viewForContent).inset(16)
                $0.height.equalTo(100)
            }
        } else {
            scrollView.snp.makeConstraints {
                $0.top.equalTo(costLabel.snp.bottom).offset(16)
                $0.trailing.leading.equalTo(viewForContent).inset(16)
                $0.height.equalTo(250)
            }
        }
        
        spinerView.snp.makeConstraints {
            $0.height.equalTo(scrollView.snp.height)
            $0.width.equalTo(scrollView.snp.width)
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
        scrollView.isUserInteractionEnabled = true
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnStackViewPressed(_:)))
        )
        scrollView.addSubview(spinerView)
        viewForContent.addSubview(scrollView)
        viewForContent.addSubview(smallDescription)
    }
}
