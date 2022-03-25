//
//  BottomController.swift
//  ImageUpload
//
//  Created by Vijay on 15/11/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit

class BottomController: UIViewController {
    
    var bottomDrawer: SecondController?
    override func viewDidLoad() {
        super.viewDidLoad()
             
        self.view.backgroundColor = UIColor.red
       //bottomDrawer = SecondController.showBuySellDrawer(controller: self)
       
//        controller.modalPresentationStyle = .custom
//        controller.transitioningDelegate = self
        //self.present(controller, animated: true, completion: nil)
        
       
    }
    @IBAction func openCloseAction(_ sender: Any) {
        
        if let controller = SecondController.loadController() {
            self.presentDrawer(presentingController: controller, contentSize: EQDrawerTypes.transaction.contentSize)
        }
    }
}


extension UIApplication {
    
    /// Fetch Top Controller from stack
    ///
    /// - Parameter base: Base controller
    /// - Returns: return Top Controller
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}



