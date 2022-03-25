//
//  UIApplication.swift
//  FICommon
//
//  Created by Sasikumar JP on 04/07/19.
//  Copyright © 2019 FundsIndia. All rights reserved.
//

import UIKit

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


// USAGES
/*
 Fetch the top of the view controller from UINavgation controller or UITabbar controller or current presen controller
 
 class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?
 Use to fetch the Top controller
 
 Example:
 let topController = ViewController.getTopViewController()
 return Top controller of view controller
 
 */
