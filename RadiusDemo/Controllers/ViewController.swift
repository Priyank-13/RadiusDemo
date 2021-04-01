//
//  ViewController.swift
//  RadiusDemo
//
//  Created by Priyank Ahuja on 21/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var facilities: [Facilities]?
    var facilityOptions: [FacilityOptions]?
    var propertyTypes: [FacilityOptions]?
    var numberOfRooms: [FacilityOptions]?
    var otherFacilities: [FacilityOptions]?
    var availableOptions: [FacilityOptions]?
    var allOptions: [FacilityOptions]?
    var exclusions: [Exclusions]?
    var unavailableOptions: [FacilityOptions]?
    var isPropertyTypeSelected = false
    
    var exclusion1: [Exclusions]?
    var exclusion2: [Exclusions]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.registerNib()
        
        if let date = UserDefaults.standard.object(forKey: "Date") as? Date {
            let calender = Calendar.current
            let isToday = calender.isDateInToday(date)
            
            if !isToday {
                self.getAPIResponse()
            } else {
                self.getFacilityOptions()
                self.getExclusions()
            }
        } else {
            self.getAPIResponse()
        }
        
        UserDefaults.standard.set(Date(), forKey: "Date")
    }
    
    func registerNib() {
        self.tableView.register(UINib(nibName: "FacilityTableViewCell", bundle: nil), forCellReuseIdentifier: "FacilityTableViewCell")
        self.tableView.register(UINib(nibName: "AvailableOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "AvailableOptionTableViewCell")
    }

    func getAPIResponse() {
        DataService.instance.getDataFromApi { (success, data, error) in
            if success {
                if let data = data {
                    DatabaseHelper.instance.saveToCoreData(object: data) { (success, error) in
                        if success {
                            print("Data store")
                            self.getFacilityOptions()
                            self.getExclusions()
                        } else {
                            print(error as Any)
                        }
                    }
                }
            } else {
                print(error as Any)
            }
        }
    }
    
    func getData() {
        DatabaseHelper.instance.emptyDatabase()
        self.getAPIResponse()
    }
    
    func getFacilities() {
        self.facilities = DatabaseHelper.instance.getFacilities()
    }
    
    func getFacilityOptions() {
        self.facilityOptions = DatabaseHelper.instance.getFacilityOptions()
        guard let facilityOptions = self.facilityOptions else {return}
        var propertyTypes = [FacilityOptions]()
        var numberOfRooms = [FacilityOptions]()
        var otherFacilities = [FacilityOptions]()
        for facilityOption in facilityOptions {
            if facilityOption.facilityId == "1" {
                propertyTypes.append(facilityOption)
            } else if facilityOption.facilityId == "2" {
                numberOfRooms.append(facilityOption)
            } else if facilityOption.facilityId == "3" {
                otherFacilities.append(facilityOption)
            }
        }
        self.propertyTypes = propertyTypes
        self.numberOfRooms = numberOfRooms
        self.otherFacilities = otherFacilities
        
        var allOptions = [FacilityOptions]()
        allOptions.append(contentsOf: numberOfRooms)
        allOptions.append(contentsOf: otherFacilities)
        self.allOptions = allOptions
        self.availableOptions = allOptions
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func getExclusions() {
        let exclusions = DatabaseHelper.instance.getexclusions()
        var exclusion1 = [Exclusions]()
        var exclusion2 = [Exclusions]()
        
        for index in 0..<exclusions.count {
            if index%2 == 0 {
                exclusion1.append(exclusions[index])
            } else {
                exclusion2.append(exclusions[index])
            }
        }
        
        self.exclusion1 = exclusion1
        self.exclusion2 = exclusion2
        self.exclusions = exclusions
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if self.isPropertyTypeSelected {
                return self.availableOptions?.count ?? 0
            } else {
                return 0
            }
        case 2:
            if self.isPropertyTypeSelected {
                return (self.unavailableOptions?.count ?? 0)
            } else {
                return 0
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FacilityTableViewCell", for: indexPath) as? FacilityTableViewCell {
                cell.delegate = self
                cell.facilities = self.facilities
                cell.propertyTypes = self.propertyTypes
                cell.collectionView.reloadData()
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableOptionTableViewCell", for: indexPath) as? AvailableOptionTableViewCell {
                guard let availableOptions = self.availableOptions else {return UITableViewCell()}
                cell.setupView(facilityOption: availableOptions[indexPath.row])
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableOptionTableViewCell", for: indexPath) as? AvailableOptionTableViewCell {
                guard let unavailableOptions = self.unavailableOptions else {return UITableViewCell()}
                cell.setupView(facilityOption: unavailableOptions[indexPath.row])
                return cell
            }
        default:
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Property Type"
        case 1:
            return "Available Options"
        case 2:
            return "Unavailable Options"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension ViewController: FacilityTableViewCellDelegate {
    func getSelectedPropertyType(propertyType: FacilityOptions) {
        guard let allOptions = self.allOptions else {return}
        guard let exclusions1 = self.exclusion1 else {return}
        guard let exclusions2 = self.exclusion2 else {return}
        
        var indexes = [Int]()
        var exclusionOptionIds = [String]()
        self.isPropertyTypeSelected = true
        
        for index in 0..<exclusions1.count {
            if exclusions1[index].optionsId == propertyType.optionId {
                indexes.append(index)
            }
        }
        
        for index in indexes {
            exclusionOptionIds.append(exclusions2[index].optionsId ?? "")
        }
        
        self.availableOptions = allOptions
        var unavailableOptions = [FacilityOptions]()
        for optionId in exclusionOptionIds {
            self.availableOptions = self.availableOptions?.filter { $0.optionId != optionId }
            
            for option in allOptions {
                if optionId == option.optionId {
                    unavailableOptions.append(option)
                }
            }
        }
        
        self.unavailableOptions = unavailableOptions
        
        self.tableView.reloadData()
    }
}

