//
//  DataNetworkResource.swift
//  OfflineEvent
//
//  Created by Vijay on 12/06/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import Foundation


public enum DataNetworkResource: ServiceResource {
    
    case fetchList(id: String)
    
    public var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/todos/")!
    }
    
    public var method: String {
        switch self {
        case .fetchList(let id):
            print("ID:\(id)")
            return id
        }
    }
    
    public var params: [String : String] {
        switch self {
        case .fetchList:
            return [:]
        }
    }
    
    public var httpMethod: HttpMethod {
        switch self {
        case .fetchList:
            return .get
        }
    }
    
    public var fileName: String {
        switch  self {
        case .fetchList:
            return ""
        }
    }
}
