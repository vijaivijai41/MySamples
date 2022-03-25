//
//  DataStore.swift
//  SwiftUISample
//
//  Created by Vijay on 19/08/20.
//



import Foundation

public class DataStore {
    public static let shared: DataStore = DataStore()

    deinit {
        print("DataStore deinit")
    }
    
    public var infoList: [InfoModel] = []
    public var countryList: [String] = []
    
}

