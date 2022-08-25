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
   
    @Persisted(primaryKey: true) var id = 0
    @Persisted var carBrend: String = ""
    @Persisted var carModel: String = ""
    @Persisted var yearOfProductionMin: Int = 0
    @Persisted var yearOfProductionMax: Int = 0
    @Persisted var costMin: Int = 0
    @Persisted var costMax: Int = 0
    @Persisted var gearbox: Int = 0
    @Persisted var typeEngine: Int = 0
    @Persisted var typeDrive: Int = 0
    @Persisted var engineCapacityMin: Double = 0
    @Persisted var engineCapacityMax: Double = 0
    @Persisted var mileage: Int = 0
    @Persisted var conditionAuto: Int = 0

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
    func getSearch() -> SearchSetting

    func getListSearchSetting() -> Results<SearchSetting>
}

class RealmService: RealmServiceProtocol {

    let realm = try! Realm()
    var searchSettingObjec = SearchSetting()
   
    var searchList = SearchSetting(value: ["id": 1])
    
    func resetSearchSetting() {
        searchList.carBrend = ""
        searchList.carModel = ""
        searchList.yearOfProductionMin = 0
        searchList.yearOfProductionMax = 0
        searchList.costMin = 0
        searchList.costMax = 0
        searchList.gearbox = 0
        searchList.typeEngine = 0
        searchList.typeDrive = 0
        searchList.engineCapacityMin = 0
        searchList.engineCapacityMax = 0
        searchList.mileage = 0
        searchList.conditionAuto = 0
        
        try! realm.write {
            realm.add(searchList)
        }
        
    }
    
    func getListSearchSetting() -> Results<SearchSetting> {
        return realm.objects(SearchSetting.self)
    }
    
    func getSearch() -> SearchSetting {
        return searchList
    }
    
    func addObjectInSearchSetting(carBrend: String) {
        try! realm.write{
            searchList.carBrend = carBrend
            realm.add(searchList, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(carModel: String) {
        try! realm.write{
            searchList.carModel = carModel
            realm.add(searchList, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(yearOfProductionMin: Int){
        try! realm.write{
            searchList.yearOfProductionMin = yearOfProductionMin
            realm.add(searchList, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(yearOfProductionMax: Int){
        try! realm.write{
            searchList.yearOfProductionMax = yearOfProductionMax
            realm.add(searchList, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(costMin: Int) {
        try! realm.write{
            searchList.costMin = costMin
            realm.add(searchList, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(costMax: Int) {
        try! realm.write{
            searchList.costMax = costMax
            realm.add(searchList, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(gearbox: Int){
        
        try! realm.write{
            searchList.gearbox = gearbox
            realm.add(searchList, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(typeEngine: Int){
        try! realm.write{
            searchList.typeEngine = typeEngine
            realm.add(searchList, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(typeDrive: Int) {
        try! realm.write{
            searchList.typeDrive = typeDrive
            realm.add(searchList, update: .modified)
        }
    }
    
   
    func addObjectInSearchSetting(engineCapacityMin: Double) {
        try! realm.write{
            searchList.engineCapacityMin = engineCapacityMin
            realm.add(searchList, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(engineCapacityMax: Double) {
        try! realm.write{
            searchList.engineCapacityMax = engineCapacityMax
            realm.add(searchList, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(mileage: Int) {
        try! realm.write{
            searchList.mileage = mileage
            realm.add(searchList, update: .modified)
        }
    }
    
    func addObjectInSearchSetting(conditionAuto: Int) {
        try! realm.write{
            searchList.conditionAuto = conditionAuto
            realm.add(searchList, update: .modified)
        }
    }
}
