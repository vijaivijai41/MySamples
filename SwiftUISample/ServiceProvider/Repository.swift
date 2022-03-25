//
//  Repository.swift
//  SwiftUISample
//
//  Created by Vijay on 19/08/20.
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
    
    // fetch all events
    public var getAllLists: [InfoModel] {
        return self.dataStore.infoList
    }
    
    public func fetchAllLists(onCompletion: @escaping(Result<[InfoModel], ErrorHandler>) ->()) {
        let resource = ListResource.fetchList
        self.apiHandler.loadApiCall(networkResource: resource) { (result) in
            switch result {
            case .success(let model):
                if let obj = model as? [InfoModel] {
                    onCompletion(.success(obj))
                } else {
                    onCompletion(.failure(.networkError))
                }
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
    
    public func fetchSelectedItem(id: String, onCompletion: @escaping(Result<InfoModel, ErrorHandler>) -> ()) {
        let resource = ListResource.fetchDetail(id: id)

        self.apiHandler.loadApiCall(networkResource: resource) { (result) in
            switch result {
            case .success(let model):
                if let obj = model as? InfoModel {
                    onCompletion(.success(obj))
                } else {
                    onCompletion(.failure(.networkError))
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
