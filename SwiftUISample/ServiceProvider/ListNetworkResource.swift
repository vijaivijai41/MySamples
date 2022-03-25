//
//  ListNetworkResource.swift
//  SwiftUISample
//
//  Created by Vijay on 19/08/20.
//

import Foundation


public enum ListResource: ServiceResource {
    
    case fetchList
    case fetchDetail(id: String)
    
    public var baseURL: URL {
        
        return URL(string: "https://jsonplaceholder.typicode.com/todos/")!
    }
    
    public var method: String {
        switch self {
        case .fetchList:
            return ""
        case .fetchDetail(let id):
            return id
        }
    }
    
    public var params: [String : String] {
        switch self {
        case .fetchList:
            return [:]
        case .fetchDetail:
            return [:]
        }
    }
    
    public var httpMethod: HttpMethod {
        switch self {
        case .fetchList:
            return .get
        case .fetchDetail:
            return .get
        }
    }
    
    public var fileName: String {
        switch  self {
        case .fetchList,.fetchDetail:
            return ""
        }
    }
}
