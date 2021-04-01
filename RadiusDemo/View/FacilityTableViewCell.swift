//
//  FacilityTableViewCell.swift
//  RadiusDemo
//
//  Created by Priyank Ahuja on 29/03/21.
//

import UIKit

protocol FacilityTableViewCellDelegate: class {
    func getSelectedPropertyType(propertyType: FacilityOptions)
}

class FacilityTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: FacilityTableViewCellDelegate?
    var facilities: [Facilities]?
    var propertyTypes: [FacilityOptions]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.resigerNib()
    }
    
    func resigerNib() {
        self.collectionView.register(UINib(nibName: "FacilityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FacilityCollectionViewCell")
    }
}

extension FacilityTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let propertyTypes = self.propertyTypes else {return 0}
        return propertyTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilityCollectionViewCell", for: indexPath) as? FacilityCollectionViewCell {
            guard let propertyTypes = self.propertyTypes else {return UICollectionViewCell()}
            cell.setupView(propertyType: propertyTypes[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let propertyTypes = self.propertyTypes else {return}
        self.delegate?.getSelectedPropertyType(propertyType: propertyTypes[indexPath.row])
    }
}
