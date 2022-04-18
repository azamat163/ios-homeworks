//
//  PlanetModel.swift
//  Navigation
//
//  Created by a.agataev on 18.04.2022.
//

import Foundation

struct PlanetModel: Codable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let residents: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter
        case climate
        case gravity
        case terrain
        case surfaceWater = "surface_water"
        case residents
        case films
        case created
        case edited
        case url
    }
}

struct PlanetPeople: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
