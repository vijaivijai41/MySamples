//
//  UIImageView.swift
//  localAuthentication
//
//  Created by Vijay on 12/07/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    /// Image View with image string Display like gmail profile
    ///
    /// - Parameter name: name string
   public func imageWithStr(_ name:String) {
        let nameLabel = UILabel(frame: self.bounds)
        nameLabel.layer.cornerRadius = self.frame.size.width / 2
        nameLabel.layer.masksToBounds = true
        nameLabel.text = splitStringToChar(name)
        nameLabel.textColor = UIColor.white
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = UIColor.randomColor
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: nameLabel.bounds)
            let image = renderer.image { rendererContext in
                nameLabel.layer.render(in: rendererContext.cgContext)
            }
            self.image = image
            
        } else {
            UIGraphicsBeginImageContext(nameLabel.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            let images = UIImage(cgImage: image!.cgImage!)
            self.image = images
        }
    }
    
    /// String split to charecter
    ///
    /// - Parameter name: name string
    /// - Returns: return first charector of each string
   fileprivate func splitStringToChar(_ name:String) -> String {
        let result = name.split(separator: " ")
        var charArray = [Character]()
        _ = result.map { (str) -> String in
            if let strr = str.first {
                charArray.append(strr)
            }
            return String(charArray)
        }
        print("filter Result:\(String(charArray))")
        return String(charArray)
    }
}

// USAGES
/*
 Image create using string like Gmail default profile image
 
 SplitStringToChar(_ name: String) -> String
 Use to conver you string split to space and return first charetor of your splited string
 
 Example:
 imageview.imageWithStr("Vijaya kumar")
 image display VK and dynamic backgriund color update in imageview bounds
 
 */
