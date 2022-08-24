//
//  ModelForCarBrendAndModel.swift
//  Used.by
//
//  Created by Artsiom Korenko on 17.08.22.
//

import Foundation
import UIKit


struct CarBrend: Codable {
    let id: Int
    let name: String
    let modelSeries: [BrendModel]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case modelSeries = "model_series"
    }
}

struct BrendModel: Codable {
    let name: String
    let modelSeriesGenerations: [Generations]?
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case modelSeriesGenerations = "model_series_generations"
    }
}

struct Generations: Codable {
    let name: String
}
