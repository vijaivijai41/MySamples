//
//  UIImage.swift
//  ImageUpload
//
//  Created by Vijay on 30/10/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {
    enum ImageQuality: CGFloat  {
        case low = 0.25
        case normal = 0.5
        case high = 1.0
    }
    
    
    /// Quality image defined as enum types
    /// - Parameter quality: quality type defined
    func qualityImage(quality: ImageQuality) -> UIImage? {
        if let imageData = jpegData(compressionQuality: quality.rawValue) {
            return UIImage(data: imageData, scale: 1.0)
        }
        return nil
    }
}
