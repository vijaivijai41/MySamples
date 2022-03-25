//
//  Repository.swift
//  MovieList
//
//  Created by Vijay on 07/07/20.
//  Copyright © 2020 Vijay. All rights reserved.
//


import Foundation
import CoreData

public enum serviceCallType {
    case create
    case update
    case delete
    case read
}

public class Repository {
        
    public let dataStore: DataStore
    public let apiHandler: WebserviceHandler
    
    public init(dataStore: DataStore, apiHandler: WebserviceHandler) {
        self.dataStore = dataStore
        self.apiHandler = apiHandler
    }
    
    
    public func fetchAnimalImage(resource:ServiceResource ,onCompletion: @escaping(Result<ImageModel, ErrorHandler>) ->()) {
        self.apiHandler.loadApiCall(networkResource: resource) { (result) in
            switch result {
            case .success(let model):
                if let image = model as? ImageModel {
                    onCompletion(.success(image))

                }
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
    
    
    public func convertData<T: Codable>(object: T) -> Data? {
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(object) {
            return jsonData
        }
        return nil
    }
    

    
}
