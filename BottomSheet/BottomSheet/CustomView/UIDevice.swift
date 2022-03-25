//
//  UIDevice.swift
//  FICommon
//
//  Created by Sasikumar JP on 04/07/19.
//  Copyright © 2019 FundsIndia. All rights reserved.
//

import UIKit

public extension UIDevice {
    
    /// Check the size class value wise is IPAD
    ///
    /// - Returns: is Ipad or not
    class func isIPAD() -> Bool {
        if UIScreen.main.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.regular &&  UIScreen.main.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.regular {
            return true
        }
        return false
    }

    /// Check the device type is iPhone
    ///
    /// Returns : true / false
    class func isPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    /// Check if the device type is iPad
    ///
    /// Returns : true / false
    class func isPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}

// USAGES
/*
 Fetch the Device of current type using Size class and trailcollections
 
 class func isIPAD() -> Bool
 is return device is iPad using trailcollection
 
 Example:
 if Device.isIPAD() {
    print("is iPad")
 }
 
 public class func isPhone() -> Bool
 is return device is iPhone  using userInterfaceIdiom
 
 Example:
 if Device.isPhone() {
 print("is iPhone")
 }
 
 
 public class func isPad() -> Bool
 is return device is iPhone  using userInterfaceIdiom
 
 Example:
 if Device.isPad() {
 print("is iPad")
 }
 

 */

