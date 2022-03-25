//
//  ViewController.swift
//  NewFireBase
//
//  Created by Vijay on 22/09/20.
//

import UIKit
import FirebaseCrashlytics


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
        button.setTitle("Crash", for: [])
        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @IBAction func crashButtonTapped(_ sender: AnyObject) {
        print(Crashlytics.crashlytics().didCrashDuringPreviousExecution())
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
           fatalError()
         }
    }

}

