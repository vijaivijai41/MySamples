//
//  ViewController.swift
//  NotificationSample
//
//  Created by Vijay on 08/07/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var deviceTokenTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func updateValue() {
        if let token = UserDefaults.standard.object(forKey: "deviceToken") as? String {
            self.deviceTokenTextView.text = token
        }
    }
    

    @IBAction func localNotificationButton(_ sender: Any) {
        MyNotificationConfigure.shared.scheduleNotification(source: .investMore, bodyContent:.investMore)
    }
    
    
}

