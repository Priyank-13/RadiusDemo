//
//  Response.swift
//  RadiusDemo
//
//  Created by Priyank Ahuja on 21/03/21.
//

import Foundation

struct ResponseData: Codable {
    let facilities: [Facility]?
    let exclusions: [[Exclusion]]?
    
    enum CodingKeys: String, CodingKey {
        case facilities = "facilities"
        case exclusions = "exclusions"
    }
}
