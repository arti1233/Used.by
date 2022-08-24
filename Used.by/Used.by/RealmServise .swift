//
//  RealmServise .swift
//  Used.by
//
//  Created by Artsiom Korenko on 23.08.22.
//

import Foundation
import RealmSwift
import UIKit

class SearchSetting: Object {
    static let id: Int = 0
    
    @objc dynamic var id: Int = SearchSetting.id
    @objc dynamic var carBrend: String = ""
    @objc dynamic var carModel: String = ""
    @objc dynamic var yearOfProductionMin: Int = 0
    @objc dynamic var yearOfProductionMax: Int = 0
    @objc dynamic var costMin: Int = 0
    @objc dynamic var costMax: Int = 0
    @objc dynamic var gearbox: Int = 0
    @objc dynamic var typeEngine: Int = 0
    @objc dynamic var typeDrive: Int = 0
    @objc dynamic var engineCapacityMin: Double = 0
    @objc dynamic var engineCapacityMax: Double = 0
    @objc dynamic var mileage: Int = 0
    @objc dynamic var conditionAuto: Int = 0

    
    override class func primaryKey() -> String? {
        return "id"
    }
}

protocol RealmServiceProtocol {
    
    func resetSearchSetting()
    func addObjectInSearchSetting(carBrend: String)
    func addObjectInSearchSetting(carModel: String)
    func addObjectInSearchSetting(yearOfProductionMin: Int)
    func addObjectInSearchSetting(yearOfProductionMax: Int)
    func addObjectInSearchSetting(costMin: Int)
    func addObjectInSearchSetting(costMax: Int)
    func addObjectInSearchSetting(gearbox: Int)
    func addObjectInSearchSetting(typeEngine: Int)
    func addObjectInSearchSetting(typeDrive: Int)
    func addObjectInSearchSetting(engineCapacityMin: Double)
    func addObjectInSearchSetting(engineCapacityMax: Double)
    func addObjectInSearchSetting(mileage: Int)
    func addObjectInSearchSetting(conditionAuto: Int)

    func getListSearchSetting() -> Results<SearchSetting>
}

class RealmService: RealmServiceProtocol {

    let realm = try! Realm()
    
    var searchSettingObject = SearchSetting()
    
    func resetSearchSetting() {
        searchSettingObject.carBrend = ""
        searchSettingObject.carModel = ""
        searchSettingObject.yearOfProductionMin = 0
        searchSettingObject.yearOfProductionMax = 0
        searchSettingObject.costMin = 0
        searchSettingObject.costMax = 0
        searchSettingObject.gearbox = 0
        searchSettingObject.typeEngine = 0
        searchSettingObject.typeDrive = 0
        searchSettingObject.engineCapacityMin = 0
        searchSettingObject.engineCapacityMax = 0
        searchSettingObject.mileage = 0
        searchSettingObject.conditionAuto = 0
        
        try! realm.write {
            realm.add(searchSettingObject)
        }
        
    }
    
    func getListSearchSetting() -> Results<SearchSetting> {
        return realm.objects(SearchSetting.self)
    }
    
    func addObjectInSearchSetting(carBrend: String) {
        try! realm.write{
            searchSettingObject.carBrend = carBrend
            realm.add(searchSettingObject, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(carModel: String) {
        try! realm.write{
            searchSettingObject.carModel = carModel
            realm.add(searchSettingObject, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(yearOfProductionMin: Int){
        try! realm.write{
            searchSettingObject.yearOfProductionMin = yearOfProductionMin
            realm.add(searchSettingObject, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(yearOfProductionMax: Int){
        try! realm.write{
            searchSettingObject.yearOfProductionMax = yearOfProductionMax
            realm.add(searchSettingObject, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(costMin: Int) {
        try! realm.write{
            searchSettingObject.costMin = costMin
            realm.add(searchSettingObject, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(costMax: Int) {
        try! realm.write{
            searchSettingObject.costMax = costMax
            realm.add(searchSettingObject, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(gearbox: Int){
        
        try! realm.write{
            searchSettingObject.gearbox = gearbox
            realm.add(searchSettingObject, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(typeEngine: Int){
        try! realm.write{
            searchSettingObject.typeEngine = typeEngine
            realm.add(searchSettingObject, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(typeDrive: Int) {
        try! realm.write{
            searchSettingObject.typeDrive = typeDrive
            realm.add(searchSettingObject, update: .modified)
        }
    }
    
   
    func addObjectInSearchSetting(engineCapacityMin: Double) {
        try! realm.write{
            searchSettingObject.engineCapacityMin = engineCapacityMin
            realm.add(searchSettingObject, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(engineCapacityMax: Double) {
        try! realm.write{
            searchSettingObject.engineCapacityMax = engineCapacityMax
            realm.add(searchSettingObject, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(mileage: Int) {
        try! realm.write{
            searchSettingObject.mileage = mileage
            realm.add(searchSettingObject, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(conditionAuto: Int) {
        try! realm.write{
            searchSettingObject.conditionAuto = conditionAuto
            realm.add(searchSettingObject, update: .modified)
        }
    }
}
