//
//  Option.swift
//  RadiusDemo
//
//  Created by Priyank Ahuja on 21/03/21.
//

import Foundation

struct Option: Codable {
    let name: String?
    let icon: String?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case icon = "icon"
        case id = "id"
    }
}
