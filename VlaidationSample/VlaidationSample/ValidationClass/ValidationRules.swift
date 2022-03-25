//
//  ValidationRules.swift
//  CommonClass
//
//  Created by Vijay on 25/07/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation

// REGEX
let mailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
let mobileRegEx = "^\\d{10}$"

// ERROR MESSAGE
let emptyEmail = "Please enter your email"
let emailNotValid = "Please enter valid email"

let emptyWarninig = "Please enter your"
let emptyOptions = "Please select your"

let emptyPassword = "Please enter your password"
let passwordMinValidate = "Password must be at least 8 charecters long"
let passwordMaxValidate = "Password must be at most 16 charecters long"

let emptyMobile = "Please enter your mobile number"
let mobileNotValid = "Mobile number must be at least 10 charecters long"


class ValidationRules {


    /// Function for validate Email
    ///
    /// - Parameter str: string for email
    /// - Returns: return error message
    public static func validateEmail(str : String) -> String? {
        if str.isEmpty {
            return emptyEmail
        } else {
            let predicate = NSPredicate(format: "SELF MATCHES %@", mailRegEx)
            if predicate.evaluate(with: str) {
                return nil
            } else {
                return emailNotValid
            }
        }
    }
    
    
    /// .... Continue for reming field validations.
    
    /// Empty Field validations
    ///
    /// - Parameters:
    ///   - str: field value
    ///   - type: type of field
    ///   - appendStr: append field str
    /// - Returns: return error message
    public static func requiredFieldsValidations(str:String ,type:EmptyFieldType,appendStr: String)-> String? {
        var errorMsg = ""
        switch type {
        case .choose:
            errorMsg = emptyOptions
        case .type:
            errorMsg = emptyWarninig
        }
        
        if str.isEmpty {
            return errorMsg + appendStr
        }
        return nil
    }
    
    public static func minimulValidation(str:String,length:Int) -> Bool {
        if str.count <= length {
            return false
        }
        return true
    }
    
    public static func maximumValidation(str:String , length:Int)->Bool {
        if str.count < length {
            return true
        }
        return false
    }
    
    public static func  validatePassword(str:String ,minLength:Int, maxLength:Int)-> String? {
        if str.isEmpty {
            return emptyPassword
        } else  {
            if ValidationRules.minimulValidation(str: str, length: minLength) {
                if ValidationRules.maximumValidation(str: str, length: maxLength) {
                    return nil
                }
                return passwordMaxValidate
            }
            return passwordMinValidate
        }
    }
    
    
    public static func validateMobile(str: String) -> String? {
        if str.isEmpty {
            return emptyMobile
        } else {
            let predicater = NSPredicate(format: "SELF MATCHES %@",mobileRegEx)
            let validate = predicater.evaluate(with: str)
            if validate {
                return nil
            }
            return mobileNotValid
        }
    }
}
