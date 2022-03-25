//
//  ValidationSource.swift
//  CommonClass
//
//  Created by Vijay on 25/07/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation

public enum EmptyFieldType {
    case type
    case choose
}


// Validation types declarations for new field like email ,password
public enum ValidationType {
    case email
    case password
    case name
    case mobile
}

// Struct for maintain every field values
public struct FieldValidate : ValidationDataSource{
    var required: Bool
    var type: ValidationType
    var fields: FITextField
    
    public init(type: ValidationType,fields: FITextField,isRequire:Bool) {
        self.type = type
        self.fields = fields
        self.required = isRequire
    }
}

// Protocal for validation datasource declarations
protocol ValidationDataSource {
    var fields: FITextField { get }
    var type: ValidationType { get }
    var required: Bool { get }
}

extension ValidationDataSource {
    
    // Error message value assign from validation model
    var errorMessage:String? {
        switch type {
            
        // EMAIL VALIDATION
        case .email:
            if required {
                let error = ValidationRules.validateEmail(str: fields.text ?? "") ?? nil
                fields.errorMsg = error ?? ""
                return error
            }
            return ""
            
            
        //PASSWORD VALIDATIONS
        case .password :
            if required {
                let error = ValidationRules.validatePassword(str: fields.text ?? "", minLength: 8, maxLength: 16) ?? nil
                fields.errorMsg = error ?? ""
                return error
            }
            return ""
            
        //NAME VALIDATION
        case .name:
            if required {
                let error = ValidationRules.requiredFieldsValidations(str: fields.text ?? "", type: .type, appendStr: "Name")
                fields.errorMsg = error ?? ""
                return error
            }
            return ""
            
        //MOBILENUMBER VALIDATION
        case .mobile:
            if required {
                let error = ValidationRules.validateMobile(str: fields.text ?? "")
                fields.errorMsg = error ?? ""
                return error
            }
            return ""
        }
    }
}

