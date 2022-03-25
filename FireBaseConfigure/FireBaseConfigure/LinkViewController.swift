//
//  LinkViewController.swift
//  FireBaseConfigure
//
//  Created by Vijay on 27/07/20.
//  Copyright © 2020 Fundsindia. All rights reserved.
//

import UIKit
import FirebaseInAppMessaging
import FirebaseAnalytics


class LinkViewController: UIViewController {

    var actionName = ""
    @IBOutlet weak var actionIdentifier: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        switch actionName {
        case "SIP":
            self.view.backgroundColor = .green
        case "Invest More":
            self.view.backgroundColor = .red
        case "Redeem":
            self.view.backgroundColor = .yellow
        default:
            break
            
        }
        

        self.actionIdentifier.text = actionName
        Analytics.logEvent("EventName", parameters: nil)
    
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


