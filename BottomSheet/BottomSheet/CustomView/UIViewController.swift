//
//  UIViewController.swift
//  FICommon
//
//  Created by Sasikumar JP on 06/07/19.
//  Copyright © 2019 FundsIndia. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Is the app running in split screen mode on iPad with
    /// iPhone traitCollection
    ///
    /// Returns - true / false
    public func isPhoneModeOnPad() -> Bool {
        return UIDevice.isPad() && traitCollection.horizontalSizeClass == .compact
    }
}


// USAGES
/*
 Fetch the boolean status for splited device screen iPad
 
 public func isPhoneModeOnPad() -> Bool

 status of splite Display
 
 Example:
 if isPhoneModeOnPad {
    print("screen splited")
 }
 
 */
