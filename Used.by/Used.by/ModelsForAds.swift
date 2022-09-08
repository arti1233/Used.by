//
//  ModelsForAds.swift
//  Used.by
//
//  Created by Artsiom Korenko on 28.08.22.
//

import Foundation

enum CreateSectionForCreateAds: CaseIterable {
    case carBrend
    case parametrs
    case cost
    case specification
    case phoneNumber
    case photo
    
    var title: String {
        switch self {
        case .carBrend:
             return "Car brend"
        case .parametrs:
            return "Technical parameters"
        case .cost:
            return "Cost"
        case .specification:
            return "Description"
        case .phoneNumber:
            return "Phone number"
        case .photo:
            return "Photo"
        }
    }
    
    var cellCount: Int {
        switch self {
        case .carBrend:
            return ModelCars.allCases.count
        case .parametrs:
            return ParametrsForAds.allCases.count
        case .cost:
            return 1
        case .specification:
            return 1
        case .phoneNumber:
            return 1
        case .photo:
            return 1
        }
    }
}

enum ParametrsForAds: CaseIterable {
    case year
    case typeEngine
    case gearbox
    case typeDrive
    case capacityEngine
    case mileage
    case condition
    
    var title: String {
        switch self {
        case .year:
            return "Year of production"
        case .typeEngine:
            return "Type engine"
        case .gearbox:
            return "Gearbox"
        case .typeDrive:
            return "Type drive"
        case .capacityEngine:
            return "Engine capacity"
        case .mileage:
            return "Mileage"
        case .condition:
            return "Condition"
        }
    }
}



