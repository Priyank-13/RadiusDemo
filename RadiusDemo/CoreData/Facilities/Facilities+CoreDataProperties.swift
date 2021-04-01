//
//  Facilities+CoreDataProperties.swift
//  RadiusDemo
//
//  Created by Priyank Ahuja on 21/03/21.
//
//

import Foundation
import CoreData


extension Facilities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Facilities> {
        return NSFetchRequest<Facilities>(entityName: "Facilities")
    }

    @NSManaged public var facilityId: String?
    @NSManaged public var name: String?

}

extension Facilities : Identifiable {

}
