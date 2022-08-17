//
//  ModelsForSearchCar.swift
//  Used.by
//
//  Created by Artsiom Korenko on 14.08.22.
//

import Foundation
import UIKit

enum CreateSections: Int, CaseIterable {
    case modelCars, techSpecifications, seller, airСonditions, exterior, securitySystems, assistanceSystems, airbag, interior, comfort, climate, headlights
    
    var title: String {
        switch self {
        case .modelCars:
            return "Model car"
        case .techSpecifications:
            return "Tech specifications"
        case .seller:
            return "Seller"
        case .airСonditions:
            return "Conditions"
        case .exterior:
            return "Exterior"
        case .securitySystems:
            return "Security systems"
        case .assistanceSystems:
            return "Assistance systems"
        case .airbag:
            return "Airbag"
        case .interior:
            return "Interior"
        case .comfort:
            return "Comfort"
        case .climate:
            return "Climate"
        case .headlights:
            return "Headlights"
        }
    }
    
    var cellCount: Int {
        switch self {
        case .modelCars:
            return ModelCars.allCases.count
        case .techSpecifications:
            return TechSpecifications.allCases.count
        case .seller:
            return Seller.allCases.count
        case .airСonditions:
            return AirСonditions.allCases.count
        case .exterior:
            return Exterior.allCases.count
        case .securitySystems:
            return SecuritySystems.allCases.count
        case .assistanceSystems:
            return AssistanceSystems.allCases.count
        case .airbag:
            return Airbag.allCases.count
        case .interior:
            return Interior.allCases.count
        case .comfort:
            return Comfort.allCases.count
        case .climate:
            return Climate.allCases.count
        case .headlights:
            return Headlights.allCases.count
        }
    }
}

enum ModelCars: CaseIterable {
    case carBrend
    case carModel
    case generation
    
    var description: String {
        switch self {
        case .carBrend:
            return "Car brend"
        case .carModel:
            return "Car model"
        case .generation:
            return "Generation"
        }
    }
}

enum TechSpecifications: CaseIterable {
    case yearOfProduction
    case cost
    case gearbox
    case typeEngine
    case typeDrive
    case bodyType
    case engineСapacity
    
    var description: String {
        switch self {
        case .yearOfProduction:
            return "Year of production"
        case .cost:
            return "Cost"
        case .typeEngine:
            return "Type engine"
        case .engineСapacity:
            return "Engine capacity"
        case .gearbox:
            return "Gearbox"
        case .typeDrive:
            return "Type drive"
        case .bodyType:
            return "Body type"
        }
    }
}



enum Seller: CaseIterable {
    case area
    case city
    
    var description: String {
        switch self {
        case .area:
            return "Area"
        case .city:
            return "City"
        }
    }
}

enum AirСonditions: CaseIterable {
    case mileage
    case conditionAuto
    
    var description: String {
        switch self {
        case .mileage:
            return "Mileage"
        case .conditionAuto:
            return "Condition auto"
        }
    }
}

enum Exterior: CaseIterable {
    case color
    case wheels
    case roofRails
    case trailerCoupling
    
    var description: String {
        switch self {
        case .color:
             return "Color"
        case .wheels:
            return "Wheels"
        case .roofRails:
            return "Roof rails"
        case .trailerCoupling:
            return "Trailer coupling"
        }
    }
}

// побитовое сложение +
enum SecuritySystems: CaseIterable {
    case abs
    case esp
    case asr
    case immobilizer
    case alarmSystem
    
    var description: String {
        switch self {
        case .abs:
            return "ABS"
        case .esp:
            return "ESP"
        case .asr:
            return "ASR"
        case .immobilizer:
            return "Imobilizer"
        case .alarmSystem:
            return "Alarm system"
        }
    }
    
    var options: SecuritySystemsStruct {
        switch self {
        case .abs:
            return .abs
        case .esp:
            return .esp
        case .asr:
            return .asr
        case .immobilizer:
            return .immobilizer
        case .alarmSystem:
            return .alarmSystem
        }
    }
}

struct SecuritySystemsStruct: OptionSet {
    var rawValue: Int
    
    static let abs = SecuritySystemsStruct(rawValue: 1 << 0)
    static let esp = SecuritySystemsStruct(rawValue: 1 << 1)
    static let asr = SecuritySystemsStruct(rawValue: 1 << 2)
    static let immobilizer = SecuritySystemsStruct(rawValue: 1 << 3)
    static let alarmSystem = SecuritySystemsStruct(rawValue: 1 << 4)
}


// побитовое сложение +
enum AssistanceSystems: CaseIterable {
    case rainSensor
    case parkCamera
    case parktronic
    case blis
    
    var description: String {
        switch self {
        case .rainSensor:
             return "Rain sensor"
        case .parkCamera:
            return "Park camera"
        case .parktronic:
            return "Parktronic"
        case .blis:
            return "BLIS"
        }
    }
    
    var options: AssistanceSystemsStruct {
        switch self {
        case .rainSensor:
            return .rainSensor
        case .parkCamera:
            return .parkCamera
        case .parktronic:
            return .parktronic
        case .blis:
            return .blis
        }
    }
}

struct AssistanceSystemsStruct: OptionSet {
    var rawValue: Int
    
    static let rainSensor = AssistanceSystemsStruct(rawValue: 1 << 0)
    static let parkCamera = AssistanceSystemsStruct(rawValue: 1 << 1)
    static let parktronic = AssistanceSystemsStruct(rawValue: 1 << 2)
    static let blis = AssistanceSystemsStruct(rawValue: 1 << 3)
}


// побитовое сложение +
enum Airbag: CaseIterable {
    case front
    case side
    case back
    
    var description: String {
        switch self {
        case .front:
            return "Front"
        case .side:
            return "Side"
        case .back:
            return "Back"
        }
    }
    
    var options: AirbagStruct {
        switch self {
        case .front:
            return .front
        case .side:
            return .side
        case .back:
            return .back
        }
    }
}

struct AirbagStruct: OptionSet {
    var rawValue: Int
    
    static let front = AirbagStruct(rawValue: 1 << 0)
    static let side = AirbagStruct(rawValue: 1 << 1)
    static let back = AirbagStruct(rawValue: 1 << 2)
}


enum Interior: CaseIterable {
    case colorInterior
    case materialInterior
    case panoramicRoof
    case hatch
    case sevenSeatVersion
    
    var description: String {
        switch self {
        case .colorInterior:
            return "Color interior"
        case .materialInterior:
            return "Material interior"
        case .panoramicRoof:
            return "Panoramic roof"
        case .hatch:
            return "Hatch"
        case .sevenSeatVersion:
            return "Seven seat version"
        }
    }
}

// побитовое сложение +
enum Comfort: CaseIterable {
    case automaticStart
    case cruiseControl
    case multiWheel
    case electricSeat
    case electricWindowFront
    case electricWindowBack
    
    var description: String {
        switch self {
        case .automaticStart:
             return "Automatic start"
        case .cruiseControl:
            return "Cruise control"
        case .multiWheel:
            return "Multi wheel"
        case .electricSeat:
            return "Electric seat"
        case .electricWindowFront:
            return "Electric window front"
        case .electricWindowBack:
            return "Electric window back"
        }
    }
    
    var options: ComfortStruct {
        switch self {
        case .automaticStart:
            return .automaticStart
        case .cruiseControl:
            return .cruiseControl
        case .multiWheel:
            return .multiWheel
        case .electricSeat:
            return .electricSeat
        case .electricWindowFront:
            return .electricWindowFront
        case .electricWindowBack:
            return .electricWindowBack
        }
    }
}

struct ComfortStruct: OptionSet {
    var rawValue: Int
    
    static let automaticStart = ComfortStruct(rawValue: 1 << 0)
    static let cruiseControl = ComfortStruct(rawValue: 1 << 1)
    static let multiWheel = ComfortStruct(rawValue: 1 << 2)
    static let electricSeat = ComfortStruct(rawValue: 1 << 3)
    static let electricWindowFront = ComfortStruct(rawValue: 1 << 4)
    static let electricWindowBack = ComfortStruct(rawValue: 1 << 5)
}

// побитовое сложение +
enum Climate: CaseIterable {
    case climateControl
    case airCondition
    
    var description: String {
        switch self {
        case .climateControl:
             return "Climate control"
        case .airCondition:
            return "Air condition"
        }
    }
    
    var options: ClimateStruct {
        switch self {
        case .climateControl:
            return .climateControl
        case .airCondition:
            return .airCondition
        }
    }
}

struct ClimateStruct: OptionSet {
    var rawValue: Int
    
    static let climateControl = ClimateStruct(rawValue: 1 << 0)
    static let airCondition = ClimateStruct(rawValue: 1 << 1)
}

// побитовое сложение +
enum Headlights: CaseIterable {
    case xenon
    case fog
    case led

    var description: String {
        switch self {
        case .xenon:
            return "xeon headlights"
        case .fog:
            return "fog headlights"
        case .led:
            return "LED headlights"
        }
    }
    
    var options: HeadlightsStruct {
        switch self {
        case .xenon:
            return .xenon
        case .fog:
            return .fog
        case .led:
            return .led
        }
    }
}

struct HeadlightsStruct: OptionSet {
    var rawValue: Int
    
    static let xenon = HeadlightsStruct(rawValue: 1 << 0)
    static let fog = HeadlightsStruct(rawValue: 1 << 1)
    static let led = HeadlightsStruct(rawValue: 1 << 2)
}
