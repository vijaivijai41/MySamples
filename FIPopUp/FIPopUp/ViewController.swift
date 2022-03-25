//
//  ViewController.swift
//  FIPopUp
//
//  Created by Vijay on 09/11/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rightButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonDidTap(_ sender: UIButton) {
        
        EQPopOverView.showPopUpView(fromView: sender, targetView: self.view, contentSize: CGSize(width: 200, height: 20))
    }
    @IBAction func barbuttonAction(_ sender: UIBarButtonItem) {
        if let view = self.fetchExactView(barbutton: sender) {
            EQPopOverView.showPopUpView(fromView: view, targetView: self.view, contentSize: CGSize(width: 200, height: 20))
        }
    }
    
    
    
}



extension UIBarButtonItem {
    var view: UIView? {
        return perform(#selector(getter: UIViewController.view)).takeRetainedValue() as? UIView
    }
    
}

