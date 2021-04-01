//
//  AvailableOptionTableViewCell.swift
//  RadiusDemo
//
//  Created by Priyank Ahuja on 29/03/21.
//

import UIKit

class AvailableOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var optionImageView: UIImageView!
    @IBOutlet weak var facilityOptionView: UIView!
    @IBOutlet weak var facilityOptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.facilityOptionView.layer.cornerRadius = 15
    }
    
    func setupView(facilityOption: FacilityOptions) {
        self.facilityOptionLabel.text = facilityOption.name
        self.optionImageView.image = UIImage(named: facilityOption.icon ?? "")
    }
}
