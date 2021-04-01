//
//  Exclusion.swift
//  RadiusDemo
//
//  Created by Priyank Ahuja on 21/03/21.
//

import Foundation

struct Exclusion: Codable {
    let facilityId: String?
    let optionsId: String?
    
    enum CodingKeys: String, CodingKey {
        case facilityId = "facility_id"
        case optionsId = "options_id"
    }
}
