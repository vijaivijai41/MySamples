//
//  FilterViewCell.swift
//  ImageUpload
//
//  Created by Vijay on 27/11/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit

class FilterViewCell: UICollectionViewCell {
    
    @IBOutlet weak var elementLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func selectedFilterCell(_ status: Bool) {
        if status {
            self.layer.borderColor = UIColor.blue.cgColor
            self.backgroundColor = UIColor.blue
            self.elementLabel.textColor = UIColor.white
        } else {
            self.layer.borderColor = UIColor.black.cgColor
            self.backgroundColor = UIColor.clear
            self.elementLabel.textColor = UIColor.black
        }
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
    }
    
    
}
