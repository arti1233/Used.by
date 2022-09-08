//
//  RealmModelForSearch.swift
//  Used.by
//
//  Created by Artsiom Korenko on 28.08.22.
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
