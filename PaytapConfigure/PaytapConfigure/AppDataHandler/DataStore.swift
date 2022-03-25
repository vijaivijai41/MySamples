//
//  DataStore.swift
//  PaytapConfigure
//
//  Created by Vijay on 10/06/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import Foundation

class DataStore {
    static let shared: DataStore = DataStore()

    private init() {}

    deinit {
        print("DataStore deinit")
    }
    
    var merchentEmail: String = "vijaivijai41@gmail.com"
    var secretKey: String = "XE8mXGWdoKFJyh1OYnMEYJftSPQBQuqO8ya6f7kERZoqgpffM2TKL9eEY5fOAGDJfOQuWa8O9weqVuFIwztiIIWGNcvoS988XYCT"
    
    var resourceBundle = Bundle(url: Bundle.main.url(forResource: "Resources", withExtension: "bundle")!)
}

