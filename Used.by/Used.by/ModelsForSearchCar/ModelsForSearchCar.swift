//
//  ModelsForSearchCar.swift
//  Used.by
//
//  Created by Artsiom Korenko on 14.08.22.
//

import Foundation
import UIKit

struct ListItem {
    var title: String
    var isSelected: Bool
    var index: Int
}


enum CreateSections: Int, CaseIterable {
    case modelCars, parametrs, typeEngine, typeDrive, gearbox, conditions
    
    var title: String {
        switch self {
        case .modelCars:
            return "Model car"
        case .parametrs:
            return "Parametrs"
        case .typeEngine:
            return "Type engine"
        case .typeDrive:
            return "Type drive"
        case .gearbox:
            return "Gearbox"
        case .conditions:
            return "Conditions"
        }
    }
    
    var cellCount: Int {
        switch self {
        case .modelCars:
            return ModelCars.allCases.count
        case .parametrs:
            return Parametrs.allCases.count
        case .typeEngine:
            return TypeEngime.allCases.count
        case .typeDrive:
            return TypeOfDrive.allCases.count
        case .gearbox:
            return GearBox.allCases.count
        case .conditions:
            return Conditions.allCases.count
        }
    }
}

enum ModelCars: CaseIterable {
    case carBrend
    case carModel
    
    var title: String {
        switch self {
        case .carBrend:
            return "Car brend"
        case .carModel:
            return "Car model"
            
        }
    }
}

enum Parametrs: CaseIterable {
    case yearOfProduction
    case cost
    case engineСapacity
    
    var title: String {
        switch self {
        case .yearOfProduction:
            return "Year of production"
        case .cost:
            return "Cost"
        case .engineСapacity:
            return "Engine capacity"
        }
    }
}

enum TypeEngime: CaseIterable {
    case petrol
    case diesel
    case hybrid
    case electro
    
    var title: String {
        switch self {
        case .petrol:
            return "Petrol"
        case .diesel:
            return "Diesel"
        case .hybrid:
            return "Hybrid"
        case .electro:
            return "Electro"
        }
    }
    
    var options: TypeEngimeStruct {
        switch self {
        case .petrol:
            return .petrol
        case .diesel:
            return .diesel
        case .hybrid:
            return .hybrid
        case .electro:
            return .electro
        }
    }
}

struct TypeEngimeStruct: OptionSet {
    var rawValue: Int
    
    static let petrol = TypeEngimeStruct(rawValue: 1 << 0)
    static let diesel = TypeEngimeStruct(rawValue: 1 << 1)
    static let hybrid = TypeEngimeStruct(rawValue: 1 << 2)
    static let electro = TypeEngimeStruct(rawValue: 1 << 3)
}


enum TypeOfDrive: CaseIterable {
    case rwd
    case fwd
    case fourWD
    case awd
    
    var title: String {
        switch self {
        case .rwd:
            return "RWD"
        case .fwd:
            return "FWD"
        case .fourWD:
            return "4WD"
        case .awd:
            return "AWD"
        }
    }
    
    var options: TypeOfDriveStruct {
        switch self {
        case .rwd:
            return .rwd
        case .fwd:
            return .fwd
        case .fourWD:
            return .fourWD
        case .awd:
            return .awd
        }
    }
    
}

struct TypeOfDriveStruct: OptionSet {
    var rawValue: Int
    
    static let rwd = TypeOfDriveStruct(rawValue: 1 << 0)
    static let fwd = TypeOfDriveStruct(rawValue: 1 << 1)
    static let fourWD = TypeOfDriveStruct(rawValue: 1 << 2)
    static let awd = TypeOfDriveStruct(rawValue: 1 << 3)
}

enum GearBox: CaseIterable {
    case manual
    case automatic
    
    var title: String {
        switch self {
        case .manual:
            return "Manual"
        case .automatic:
            return "Automatic"
        }
    }
    
    var options: GearBoxStruct {
        switch self {
        case .manual:
            return .manual
        case .automatic:
            return .automatic
        }
    }
}

struct GearBoxStruct: OptionSet {
    var rawValue: Int
    
    static let manual = GearBoxStruct(rawValue: 1 << 0)
    static let automatic = GearBoxStruct(rawValue: 1 << 1)
}

enum Conditions: CaseIterable {
    case mileage
    case new
    case used
    case crash
    case forParts
    
    var title: String {
        switch self {
        case .mileage:
            return "Mileage"
        case .new:
            return "New"
        case .used:
            return "Used"
        case .crash:
            return "Crash"
        case .forParts:
            return "For parts"
        }
    }
    
    var options: ConditionStruct {
        switch self {
        case .new:
            return .new
        case .used:
            return .used
        case .crash:
            return .crash
        case .forParts:
            return .forParts
        default:
            return ConditionStruct()
        }
    }
}

struct ConditionStruct: OptionSet {
    var rawValue: Int
    
    static let new = ConditionStruct(rawValue: 1 << 0)
    static let used = ConditionStruct(rawValue: 1 << 1)
    static let crash = ConditionStruct(rawValue: 1 << 2)
    static let forParts = ConditionStruct(rawValue: 1 << 3)
}






