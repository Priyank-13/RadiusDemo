//
//  DatabaseHelper.swift
//  RadiusDemo
//
//  Created by Priyank Ahuja on 21/03/21.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    
    static let instance = DatabaseHelper()
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func saveToCoreData(object: ResponseData, completionHandler: @escaping (_ success: Bool,_ error: String?)->()) {
        
        self.emptyDatabase()
        
        if let facilitiesData = object.facilities {
            for facility in facilitiesData {
                guard let facilities = NSEntityDescription.insertNewObject(forEntityName: "Facilities", into: context!) as? Facilities else {return}
                facilities.facilityId = facility.facilityId
                facilities.name = facility.name

                guard let optionsData = facility.options else {continue}
                for option in optionsData {
                    guard let facilityOptions = NSEntityDescription.insertNewObject(forEntityName: "FacilityOptions", into: context!) as? FacilityOptions else {return}
                    facilityOptions.optionId = option.id
                    facilityOptions.name = option.name
                    facilityOptions.icon = option.icon
                    facilityOptions.facilityId = facility.facilityId

                    do {
                        try context?.save()
                    } catch let error {
                        print(error.localizedDescription as Any)
                        completionHandler(false, error.localizedDescription)
                    }
                }
            }
        }
        
        if let exclusionsData = object.exclusions {
            for exclusionArray in exclusionsData {
                for exclusion in exclusionArray {
                    guard let exclusions = NSEntityDescription.insertNewObject(forEntityName: "Exclusions", into: context!) as? Exclusions else {return}
                    exclusions.facilityId = exclusion.facilityId
                    exclusions.optionsId = exclusion.optionsId
                    
                    do {
                        try context?.save()
                       
                    } catch let error {
                        print(error.localizedDescription as Any)
                        completionHandler(false, error.localizedDescription)
                    }
                }
            }
        }
        completionHandler(true, nil)
    }
    
    func emptyDatabase() {
        var facilities = [Facilities]()
        var facilityOptions = [FacilityOptions]()
        var exclusions = [Exclusions]()
        let facilitiesFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Facilities")
        let facilityOptionsFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FacilityOptions")
        let exclusionsFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exclusions")
        do {
            facilities = try context?.fetch(facilitiesFetchRequest) as! [Facilities]
            for facility in facilities {
                context?.delete(facility)
                
                try context?.save()
            }
            
            facilityOptions = try context?.fetch(facilityOptionsFetchRequest) as! [FacilityOptions]
            for facilityOption in facilityOptions {
                context?.delete(facilityOption)
                
                try context?.save()
            }
            
            exclusions = try context?.fetch(exclusionsFetchRequest) as! [Exclusions]
            for exclusion in exclusions {
                context?.delete(exclusion)
                
                try context?.save()
            }
        } catch {
            print("")
        }
    }
    
    func getFacilities() -> [Facilities] {
        var facilities = [Facilities]()
        let facilitiesFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Facilities")
        do {
            facilities = try context?.fetch(facilitiesFetchRequest) as! [Facilities]
        } catch {
            print("error")
        }
        
        return facilities
    }
    
    func getFacilityOptions() -> [FacilityOptions] {
        var facilityOptions = [FacilityOptions]()
        let facilityOptionsFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FacilityOptions")
        do {
            facilityOptions = try context?.fetch(facilityOptionsFetchRequest) as! [FacilityOptions]
        } catch {
            print("error")
        }
        return facilityOptions
    }
    
    func getexclusions() -> [Exclusions] {
        var exclusions = [Exclusions]()
        let exclusionsFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exclusions")
        do {
            exclusions = try context?.fetch(exclusionsFetchRequest) as! [Exclusions]
        } catch {
            print("ERROR")
        }
        return exclusions
    }
}
