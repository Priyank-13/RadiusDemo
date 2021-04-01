//
//  FacilityCollectionViewCell.swift
//  RadiusDemo
//
//  Created by Priyank Ahuja on 29/03/21.
//

import UIKit

class FacilityCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cellView.layer.cornerRadius = 15
    }
    
    func setupView(propertyType: FacilityOptions) {
        self.titleLabel.text = propertyType.name
        self.imageView.image = UIImage(named: propertyType.icon ?? "")
    }

}
