//
//  Exclusions+CoreDataProperties.swift
//  RadiusDemo
//
//  Created by Priyank Ahuja on 21/03/21.
//
//

import Foundation
import CoreData


extension Exclusions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exclusions> {
        return NSFetchRequest<Exclusions>(entityName: "Exclusions")
    }

    @NSManaged public var facilityId: String?
    @NSManaged public var optionsId: String?

}

extension Exclusions : Identifiable {

}
