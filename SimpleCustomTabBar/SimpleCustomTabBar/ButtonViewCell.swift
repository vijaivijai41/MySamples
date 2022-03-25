//
//  ButtonViewCell.swift
//  SimpleCustomTabBar
//
//  Created by Vijay on 19/08/20.
//

import UIKit

class ButtonViewCell: UITableViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
