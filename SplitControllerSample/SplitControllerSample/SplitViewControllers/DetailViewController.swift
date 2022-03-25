//
//  DetailViewController.swift
//  SplitControllerSample
//
//  Created by FIuser on 01/07/19.
//  Copyright © 2019 FundsIndia. All rights reserved.
//

import UIKit

class DetailViewController: BaseController {

    @IBOutlet weak var commonTable: CommonTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        commonTable.cellIdentifier =  "this is 1st page"
        commonTable.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(uiBarChanges), name: NSNotification.Name.init("SplitChangesNotification"), object: nil)
        uiBarChanges()
    }
    
    @objc func uiBarChanges() {
        if isSplited {
            self.isMenuShow = true
            self.addLeftMenuButton(title: "Menu", image: nil, selector: #selector(showSideMenu(_:)))
        } else {
            self.navigationItem.setLeftBarButton(nil, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    @IBAction func showSideMenu(_ sender: Any) {
        self.showHideSplitView()
    }
   
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

