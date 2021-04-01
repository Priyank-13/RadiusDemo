//
//  FacilityOptions+CoreDataProperties.swift
//  RadiusDemo
//
//  Created by Priyank Ahuja on 21/03/21.
//
//

import Foundation
import CoreData


extension FacilityOptions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FacilityOptions> {
        return NSFetchRequest<FacilityOptions>(entityName: "FacilityOptions")
    }

    @NSManaged public var name: String?
    @NSManaged public var icon: String?
    @NSManaged public var optionId: String?
    @NSManaged public var facilityId: String?

}

extension FacilityOptions : Identifiable {

}
