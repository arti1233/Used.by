//
//  RealmServise .swift
//  Used.by
//
//  Created by Artsiom Korenko on 23.08.22.
//

import Foundation
import RealmSwift
import UIKit

protocol RealmServiceProtocol {
//Metods for UserData
    func resertUserData()
    func addUserData(ID: String)
    func addUserData(isAuthFirebase: Bool)
    func addUserData(isUserSignIn: Bool)
    
//Metods for add ads params
    func resetAdsParams()
    func addAdsParams(carBrendName: String)
    func addAdsParams(carModelName: String)
    func addAdsParams(year: Int)
    func addAdsParams(typeEngine: Int)
    func addAdsParams(gearbox: Int)
    func addAdsParams(typeDrive: Int)
    func addAdsParams(capacity: Int)
    func addAdsParams(mileage: Int)
    func addAdsParams(descriptionCar: String)
    func addAdsParams(phone: Int)
    func addAdsParams(cost: Int)
    func addAdsParams(condition: Int)

//Metods for search ads
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
    func getAdsConfigureList() -> Results<AdsConfigure>
    func getUsersRealmModel() -> Results<UserRealmModel>

    func getAdsParams() -> AdsConfigure
    func getSearch() -> SearchSetting
    func getUserData() -> UserRealmModel
    
    
}

class RealmService: RealmServiceProtocol {

    let realm = try! Realm()
    
    private lazy var searchList: SearchSetting = {
        getListSearchSetting().first ?? SearchSetting()
    }()
    
    private lazy var adsConfigure: AdsConfigure = {
        getAdsConfigureList().first ?? AdsConfigure()
    }()
    
    private lazy var userData: UserRealmModel = {
        getUsersRealmModel().first ?? UserRealmModel()
    }()
    
    func resetSearchSetting() {
        try! realm.write {
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
            realm.add(searchList)
        }
    }
    
    func resetAdsParams() {
        try! realm.write {
            adsConfigure.carBrendName = ""
            adsConfigure.carModelName = ""
            adsConfigure.year = 0
            adsConfigure.typeEngine = 0
            adsConfigure.gearbox = 0
            adsConfigure.typeDrive = 0
            adsConfigure.capacity = 0
            adsConfigure.mileage = 0
            adsConfigure.descriptionCar = ""
            adsConfigure.phoneNumber = 0
            adsConfigure.cost = 0
            realm.add(adsConfigure, update: .modified)
        }
    }
    
    func resertUserData() {
        try! realm.write {
            userData.userID = ""
            userData.isUserSingIn = false
            userData.isAuthFirebase = false
            realm.add(userData)
        }
    }
    
    func getAdsConfigureList() -> Results<AdsConfigure> {
        return realm.objects(AdsConfigure.self)
    }
    
    func getListSearchSetting() -> Results<SearchSetting> {
        return realm.objects(SearchSetting.self)
    }
    
    func getUsersRealmModel() -> Results<UserRealmModel> {
        return realm.objects(UserRealmModel.self)
    }
    
    func getSearch() -> SearchSetting {
        return searchList
    }
    
    func getAdsParams() -> AdsConfigure {
        return adsConfigure
    }
    
    func getUserData() -> UserRealmModel {
        return userData
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
    
    
    func addAdsParams(carBrendName: String) {
        try! realm.write{
            adsConfigure.carBrendName = carBrendName
            realm.add(adsConfigure, update: .modified)
        }
    }
    
    func addAdsParams(carModelName: String) {
        try! realm.write{
            adsConfigure.carModelName = carModelName
            realm.add(adsConfigure, update: .modified)
        }
    }
    
    func addAdsParams(year: Int) {
        try! realm.write{
            adsConfigure.year = year
            realm.add(adsConfigure, update: .modified)
        }
    }
    
    func addAdsParams(typeEngine: Int) {
        try! realm.write{
            adsConfigure.typeEngine = typeEngine
            realm.add(adsConfigure, update: .modified)
        }
    }
    
    func addAdsParams(gearbox: Int) {
        try! realm.write{
            adsConfigure.gearbox = gearbox
            realm.add(adsConfigure, update: .modified)
        }
    }
    
    func addAdsParams(typeDrive: Int) {
        try! realm.write{
            adsConfigure.typeDrive = typeDrive
            realm.add(adsConfigure, update: .modified)
        }
    }
    
    func addAdsParams(capacity: Int) {
        try! realm.write{
            adsConfigure.capacity = capacity
            realm.add(adsConfigure, update: .modified)
        }
    }
    
    func addAdsParams(mileage: Int) {
        try! realm.write{
            adsConfigure.mileage = mileage
            realm.add(adsConfigure, update: .modified)
        }
    }
    
    func addAdsParams(descriptionCar: String) {
        try! realm.write{
            adsConfigure.descriptionCar = descriptionCar
            realm.add(adsConfigure, update: .modified)
        }
    }
    
    func addAdsParams(phone: Int) {
        try! realm.write{
            adsConfigure.phoneNumber = phone
            realm.add(adsConfigure, update: .modified)
        }
    }
    
    func addAdsParams(cost: Int) {
        try! realm.write{
            adsConfigure.cost = cost
            realm.add(adsConfigure, update: .modified)
        }
    }
    
    func addAdsParams(condition: Int) {
        try! realm.write{
            adsConfigure.condition = condition
            realm.add(adsConfigure, update: .modified)
        }
    }
    
    func addUserData(ID: String) {
        try! realm.write{
            userData.userID = ID
            realm.add(userData, update: .modified)
        }
    }
    
    func addUserData(isAuthFirebase: Bool){
        try! realm.write{
            userData.isAuthFirebase = isAuthFirebase
            realm.add(userData, update: .modified)
        }
    }
    
    func addUserData(isUserSignIn: Bool) {
        try! realm.write{
            userData.isUserSingIn = isUserSignIn
            realm.add(userData, update: .modified)
        }
    }
}
