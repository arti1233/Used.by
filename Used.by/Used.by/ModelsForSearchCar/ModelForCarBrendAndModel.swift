//
//  ModelForCarBrendAndModel.swift
//  Used.by
//
//  Created by Artsiom Korenko on 17.08.22.
//

import Foundation
import UIKit
import SwiftProtobuf


enum CarBrend: CaseIterable {
    case alfaRomeo, dodge, kia, nissan, skoda, audi, fiat, lada, opel, subaru, bmv, ford, lexus, peugeot, suzuki, chevrolet, geely, mazda, renault, toyota, chrysler, honda, mercedesBenz, rover, volkswagen, citroen, hyundai, mitsubishi, seat, volvo
    
    var title: String {
        switch self {
        case .alfaRomeo:
            return "AlfaRomeo"
        case .dodge:
            return "Dodge"
        case .kia:
            return "Kia"
        case .nissan:
            return "Nissan"
        case .skoda:
            return "Skoda"
        case .audi:
            return "Audi"
        case .fiat:
            return "Fiat"
        case .lada:
            return "Lada"
        case .opel:
            return "Opel"
        case .subaru:
            return "Subaru"
        case .bmv:
            return "BMW"
        case .ford:
            return "Ford"
        case .lexus:
            return "Lexus"
        case .peugeot:
            return "Peugeot"
        case .suzuki:
            return "Suzuki"
        case .chevrolet:
            return "Chevrolet"
        case .geely:
            return "Geely"
        case .mazda:
            return "Mazda"
        case .renault:
            return "Renault"
        case .toyota:
            return "Toyota"
        case .chrysler:
            return "Chrysler"
        case .honda:
            return "Honda"
        case .mercedesBenz:
            return "Mercedes-Benz"
        case .rover:
            return "Rover"
        case .volkswagen:
            return "Volkswagen"
        case .citroen:
            return "Citroen"
        case .hyundai:
            return "Hyundai"
        case .mitsubishi:
            return "Mitsubishi"
        case .seat:
            return "SEAT"
        case .volvo:
            return "Volvo"
        }
    }
    
    var modelcar: Any {
        switch self {
        case .alfaRomeo:
            return AlfaRomeo.self
        case .dodge:
            return Dodge.self
        case .kia:
            return Kia.self
        case .nissan:
            return Nissan.self
        case .skoda:
            return Skoda.self
        case .audi:
            return Audi.self
        case .fiat:
            return Fiat.self
        case .lada:
            return Lada.self
        case .opel:
            return Opel.self
        case .subaru:
            return Subaru.self
        case .bmv:
            return BMW.self
        case .ford:
            return Ford.self
        case .lexus:
            return Lexus.self
        case .peugeot:
            return Peugeot.self
        case .suzuki:
            return Suzuki.self
        case .chevrolet:
            return Chevrolet.self
        case .geely:
            return Geely.self
        case .mazda:
            return Mazda.self
        case .renault:
            return Renault.self
        case .toyota:
            return Toyota.self
        case .chrysler:
            return Chrysler.self
        case .honda:
            return Honda.self
        case .mercedesBenz:
            return MercedesBenz.self
        case .rover:
            return Rover.self
        case .volkswagen:
            return Volkswagen.self
        case .citroen:
            return Citroen.self
        case .hyundai:
            return Hyundai.self
        case .mitsubishi:
            return Mitsubishi.self
        case .seat:
            return SEAT.self
        case .volvo:
            return Volvo.self
        }
    }
}



enum AlfaRomeo: CaseIterable {
    case m145, m155, m164, giulia, gtv, m146, m156, m166, giulietta, miTo, m147, m159, brera, gt, stelvio
    
    var title: String {
        switch self {
        case .m145:
            return "145"
        case .m155:
            return "155"
        case .m164:
            return "164"
        case .giulia:
            return "Giulia"
        case .gtv:
            return "GTV"
        case .m146:
            return "146"
        case .m156:
            return "156"
        case .m166:
            return "166"
        case .giulietta:
            return "Giulietta"
        case .miTo:
            return "MiTo"
        case .m147:
            return "147"
        case .m159:
            return "159"
        case .brera:
            return "Brera"
        case .gt:
            return "GT"
        case .stelvio:
            return "Stelvio"
        }
    }
}

enum Dodge: CaseIterable {
    case avenger, charger, grandCaravan, neon, ramVan, caliber, dakota, intrepid, nitro, stratus, caravan, dart, journey, ram, challenger, durango, magnum, city

    var title: String {
        switch self {
        case .avenger:
            return "Avenger"
        case .charger:
            return "Charger"
        case .grandCaravan:
            return "Grand Caravan"
        case .neon:
            return "Neon"
        case .ramVan:
            return "Ram Van"
        case .caliber:
            return "Caliber"
        case .dakota:
            return "Dakota"
        case .intrepid:
            return "Intrepid"
        case .nitro:
            return "Nitro"
        case .stratus:
            return "Stratus"
        case .caravan:
            return "Caravan"
        case .dart:
            return "Dart"
        case .journey:
            return "Journey"
        case .ram:
            return "RAM"
        case .challenger:
            return "Challenger"
        case .durango:
            return "Durango"
        case .magnum:
            return "Magnum"
        case .city:
            return "City"
        }
    }
}
enum Kia: CaseIterable {
    case Besta, Joice, Optima, Sedona, SoulEV, Carens, K5, Picanto, Seltos, Spectra, Carnival, Magentis, Pride, Sephia, Sportage, Ceed, Mohave, Quoris, Shuma, Stinger, Cerato, Niro, Retona, Sorento, Stonic, Clarus, Opirus, Rio, Soul, Venga

    var title: String {
        switch self {
        case .Besta:
            return "Besta"
        case .Joice:
            return "Joice"
        case .Optima:
            return "Optima"
        case .Sedona:
            return "Sedona"
        case .SoulEV:
            return "SoulEV"
        case .Carens:
            return "Carens"
        case .K5:
            return "K5"
        case .Picanto:
            return "Picanto"
        case .Seltos:
            return "Seltos"
        case .Spectra:
            return "Spectra"
        case .Carnival:
            return "Carnival"
        case .Magentis:
            return "Magentis"
        case .Pride:
            return "Pride"
        case .Sephia:
            return "Sephia"
        case .Sportage:
            return "Sportage"
        case .Ceed:
            return "Ceed"
        case .Mohave:
            return "Mohave"
        case .Quoris:
            return "Quoris"
        case .Shuma:
            return "Shuma"
        case .Stinger:
            return "Stinger"
        case .Cerato:
            return "Cerato"
        case .Niro:
            return "Niro"
        case .Retona:
            return "Retona"
        case .Sorento:
            return "Sorento"
        case .Stonic:
            return "Stonic"
        case .Clarus:
            return "Clarus"
        case .Opirus:
            return "Opirus"
        case .Rio:
            return "Rio"
        case .Soul:
            return "Soul"
        case .Venga:
            return "Venga"
        }
    }
}
enum Nissan: CaseIterable {
    
}
enum Skoda: CaseIterable {
    
}
enum Audi: CaseIterable {
    
}
enum Fiat: CaseIterable {
    
}
enum Lada: CaseIterable {
    
}
enum Opel: CaseIterable {
    
}
enum Subaru: CaseIterable {
    
}
enum BMW: CaseIterable {
    
}
enum Ford: CaseIterable {
    
}
enum Lexus: CaseIterable {
    
}
enum Peugeot: CaseIterable {
    
}
enum Suzuki: CaseIterable {
    
}
enum Chevrolet: CaseIterable {
    
}
enum Geely: CaseIterable {
    
}
enum Mazda: CaseIterable {
    
}
enum Renault: CaseIterable {
    
}
enum Toyota: CaseIterable {
    
}
enum Chrysler: CaseIterable {
    
}
enum Honda: CaseIterable {
    
}
enum MercedesBenz: CaseIterable {
}

enum Rover: CaseIterable {
}

enum Volkswagen: CaseIterable {
}

enum Citroen: CaseIterable {
}

enum Hyundai: CaseIterable {
    
}

enum Mitsubishi: CaseIterable {
    
}

enum SEAT: CaseIterable {
    
}

enum Volvo: CaseIterable {
    
}


 

