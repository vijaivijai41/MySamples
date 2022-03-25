//
//  ViewController.swift
//  simplCoordinaterSample
//
//  Created by Vijay on 08/11/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    public weak var delegate: MainCoordinatorDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet var showProfile: UIView!
    
    @IBAction func secondAction(_ sender: Any) {
        delegate?.moveSecondController()
    }
    @IBAction func showProfile(_ sender: Any) {
        delegate?.showProfile()
    }
}

