
//  ValidationSource.swift
//  CommonClass
//
//  Created by Vijay on 24/07/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation


/// Validation class
open class Validate {
    
    public init() { }
    public var errorsArray: [String] = [String]()
    public var fields: [FieldValidate] = [FieldValidate]()
    public func addValidate(validationSource: [FieldValidate]) {
        fields = validationSource
    }
    
    /// Check error message is availavle or not
    public func validate() {
        for s in fields {
            s.fields.errorMsg = s.errorMessage ?? ""
        }
    }
    
    /// Check valiation in whatever place with assign datasources
    public var isSuccess: Bool {
        validate()
        let error = fields.filter {$0.fields.errorMsg != ""}
        self.errorsArray = fields.map{ $0.errorMessage ?? "" }
        return error.count > 0 ? false : true
    }
}

