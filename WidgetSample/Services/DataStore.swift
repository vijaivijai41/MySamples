//
//  DataStore.swift
//  MovieList
//
//  Created by Vijay on 07/07/20.
//  Copyright © 2020 Vijay. All rights reserved.
//


import Foundation

public class DataStore {
    public static let shared: DataStore = DataStore()

    deinit {
        print("DataStore deinit")
    }
    
    public var images: ImageModel? = nil
    
}

