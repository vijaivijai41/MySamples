//
//  EQWatchlistSortCell.swift
//  ImageUpload
//
//  Created by Vijay on 27/11/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit

class EQWatchlistSortCell: UICollectionViewCell {

    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var elamentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func selectedSortCell(_ status: Bool) {
        if status {
            self.selectionView.backgroundColor = UIColor.red
        } else {
            self.selectionView.backgroundColor = UIColor.clear
        }
        self.bringSubviewToFront(self.selectionView)
    }

}
