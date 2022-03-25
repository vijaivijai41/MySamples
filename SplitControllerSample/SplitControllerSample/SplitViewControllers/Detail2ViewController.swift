//
//  Detail2ViewController.swift
//  SplitControllerSample
//
//  Created by FIuser on 01/07/19.
//  Copyright © 2019 FundsIndia. All rights reserved.
//

import UIKit

class Detail2ViewController: BaseController {
    @IBOutlet weak var commonTable: CommonTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        NotificationCenter.default.addObserver(self, selector: #selector(uiBarChanges), name: NSNotification.Name.init("SplitChangesNotification"), object: nil)
        // Do any additional setup after loading the view.
        uiBarChanges()
        commonTable.cellIdentifier = "this is 2nd page"
        commonTable.reloadData()
    }
    @IBAction func showSideMenu(_ sender: UIBarButtonItem) {
      self.showHideSplitView()
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

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
