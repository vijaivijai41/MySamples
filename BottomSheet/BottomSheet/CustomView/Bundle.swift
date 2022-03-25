//
//  Bundle.swift
//  FICommon
//
//  Created by Sasikumar JP on 05/07/19.
//  Copyright © 2019 FundsIndia. All rights reserved.
//

import Foundation

extension Bundle {
    
    public var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    public var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    public var bundleIdentifier: String? {
        return infoDictionary?["CFBundleIdentifier"] as? String
    }    
}
