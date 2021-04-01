//
//  Facility.swift
//  RadiusDemo
//
//  Created by Priyank Ahuja on 21/03/21.
//

import Foundation

struct Facility: Codable {
    let facilityId: String?
    let name: String?
    let options: [Option]?
    
    enum CodingKeys: String, CodingKey {
        case facilityId = "facility_id"
        case name = "name"
        case options = "options"
    }
}
