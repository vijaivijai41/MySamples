//
//  Repository.swift
//  PaytapConfigure
//
//  Created by Vijay on 10/06/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import Foundation

class Repository {
        
    let dataStore: DataStore
    
    init(dataStore: DataStore) {
        self.dataStore = dataStore
    }
    
    // fetch merchent email
    var getMerchentEmail: String {
         return self.dataStore.merchentEmail
    }
    
    // fetch secret key
    var getSecretKey: String {
         return self.dataStore.secretKey
    }
    
    // get resource bundle
    var getResourceBundle: Bundle? {
        return self.dataStore.resourceBundle
    }
    
}
