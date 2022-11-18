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
        label.numberOfLines = 0
        label.tintColor = .myCustomPurple
        return label
    }()
    
    private lazy var costLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .heavy)
        label.tintColor = .myCustomPurple
        return label
    }()
    
    private lazy var layoutForCollectionView: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset.left = 0
        layout.sectionInset.right = 0
        layout.sectionInset.bottom = 0
        layout.sectionInset.top = 0
        return layout
    }()
    
    private lazy var colectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutForCollectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionCellForPhoto.self, forCellWithReuseIdentifier: CollectionCellForPhoto.key)
        collectionView.layer.cornerRadius = 10
        return collectionView
    }()
    
    private lazy var smallDescription: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.tintColor = .myCustomPurple
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var spinerView: UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView()
        spiner.backgroundColor = .mainBackgroundColor
        spiner.hidesWhenStopped = true
        spiner.layer.cornerRadius = 10
        return spiner
    }()
    
    private let cache = NSCache<NSNumber, UIImage>()

    var complition: (([UIImage]) -> Void)?
    var isTransitionOnLookPhoto = false
    var isSmallCell = true
    var arrayImage: [UIImage] = []
    
//MARK: Override functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if isSmallCell {
            layoutForCollectionView.itemSize = CGSize(width: 100,
                                                      height: 100)
        } else {
            layoutForCollectionView.itemSize = CGSize(width: contentView.frame.width - 48,
                                                      height: 250)
        }
        addElements()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()
        if isSmallCell {
            layoutForCollectionView.itemSize = CGSize(width: 100,
                                                      height: 100)
        } else {
            layoutForCollectionView.itemSize = CGSize(width: contentView.frame.width - 48,
                                                      height: 250)
        }
        addConstraint(isSmallCell: isSmallCell)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        colectionView.subviews.forEach({$0.removeFromSuperview()})
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
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            urlPhoto.forEach({arrayImage.append($0.image)})
            self.arrayImage = arrayImage
            DispatchQueue.main.async {
                self.colectionView.reloadData()
                self.spinerView.stopAnimating()
            }
        }
        
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
    
    
        colectionView.snp.makeConstraints {
            $0.top.equalTo(costLabel.snp.bottom).offset(16)
            $0.trailing.leading.equalTo(viewForContent).inset(16)
            $0.height.equalTo(isSmallCell ? 100 : 250)
        }
   
        spinerView.snp.makeConstraints {
            $0.top.equalTo(costLabel.snp.bottom).offset(16)
            $0.trailing.leading.equalTo(viewForContent).inset(16)
            $0.height.equalTo(isSmallCell ? 100 : 250)
        }

        smallDescription.snp.makeConstraints {
            $0.top.equalTo(colectionView.snp.bottom).offset(16)
            $0.trailing.leading.bottom.equalTo(viewForContent).inset(16)
        }
        
    }
    
    private func addElements() {
        contentView.addSubview(viewForContent)
        viewForContent.addSubview(titleCell)
        viewForContent.addSubview(costLabel)
        viewForContent.addSubview(colectionView)
        viewForContent.addSubview(spinerView)
        colectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnStackViewPressed(_:))))
        viewForContent.addSubview(smallDescription)
    }
}


extension AdsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellForPhoto.key, for: indexPath) as? CollectionCellForPhoto else { return UICollectionViewCell() }
        cell.prepareForReuse()
        cell.changeImage(image: arrayImage[indexPath.row])
        return cell
    }
}
