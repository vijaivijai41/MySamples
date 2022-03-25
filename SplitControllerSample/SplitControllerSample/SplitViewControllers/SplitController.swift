//
//  SplitController.swift
//  SplitControllerSample
//
//  Created by FIuser on 01/07/19.
//  Copyright © 2019 FundsIndia. All rights reserved.
//

import UIKit

class SplitController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.maximumPrimaryColumnWidth = UIScreen.main.bounds.size.width - 150
        
    }
}


