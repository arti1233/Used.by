//
//  RealmModelForAds.swift
//  Used.by
//
//  Created by Artsiom Korenko on 28.08.22.
//

import Foundation
import RealmSwift
import UIKit
 
class AdsConfigure: Object {
    
    @Persisted(primaryKey: true) var id = 0 
    @Persisted var carBrendName: String = ""
    @Persisted var carModelName: String = ""
    @Persisted var year: Int = 0
    @Persisted var typeEngine: Int = 0
    @Persisted var gearbox: Int = 0
    @Persisted var typeDrive: Int = 0
    @Persisted var capacity: Int = 0
    @Persisted var mileage: Int = 0
    @Persisted var descriptionCar: String = ""
    @Persisted var phoneNumber: Int = 0
    @Persisted var cost: Int = 0
    @Persisted var condition: Int = 0
}
