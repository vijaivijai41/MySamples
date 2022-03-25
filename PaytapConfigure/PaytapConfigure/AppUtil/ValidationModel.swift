//
//  ValidationModel.swift
//  PaytapConfigure
//
//  Created by Vijay on 10/06/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import Foundation
import UIKit

class ValidationModel {
    
    static func checkoutValidation(username: String, amount: String, email: String, mobile: String) -> Bool {
        if ValidationModel.emptyValidation(field: username, error: "Please enter user name") {
            if ValidationModel.emptyValidation(field: amount, error: "Please enter amount") {
                if ValidationModel.emptyValidation(field: email, error: "Please enter email") {
                    if ValidationModel.emptyValidation(field: mobile, error: "Please enter mobile number") {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    
    static func emptyValidation(field: String, error: String) -> Bool {
        if field.isEmpty {
            UIApplication.topViewController()?.showAlert(message: error, okButtonAction: nil)
            return false
        }
        return true
    }
}



