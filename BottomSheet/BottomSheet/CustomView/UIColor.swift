//
//  UIColor.swift
//  localAuthentication
//
//  Created by Vijay on 12/07/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    ///  Create Random color code for each time load different image color
    static var randomColor : UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
}


// USAGES
/*
 Create Dynamic color from UIColor use of random(in:0...1) use to fetch RGB combinations
 
 static var randomColor : UIColor
 Variable use to create random color
 
 Example:
 let view = UIView(frame: self.bounds)
 view.backgroundColor = UIColor.randomColor
 self.addSubView(view)
 
 //Display the each and every time load different color
 
 */
