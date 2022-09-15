//
//  UserModel.swift
//  Used.by
//
//  Created by Artsiom Korenko on 19.08.22.
//

import Foundation

struct Users: Codable {
    let email: String
    let name: String
}

struct AllAdsId: Codable {
    let id: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
    }
}

struct AdsInfo: Codable {
    let capacity: Double
    let carBrend, carModel: String
    let condition, cost: Int
    let responseDescription: String
    let gearBox: Int
    let id: String
    let mileage, phoneNumber: Int
    let photo: [String]
    let typeDrive, typeEngine, year: Int

    enum CodingKeys: String, CodingKey {
        case capacity, carBrend, carModel, condition, cost
        case responseDescription = "description"
        case gearBox, id, mileage, phoneNumber, photo, typeDrive, typeEngine, year
    }
}

struct UsersAds: Codable {
    let adsId: [String]
}

struct UsersSaveAds: Codable {
    let saveAds: [String]
}
