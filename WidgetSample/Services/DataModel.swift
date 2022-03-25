//
//  DataModel.swift
//  Services
//
//  Created by Vijay on 13/08/20.
//

import Foundation


public struct ImageModel: Codable {
    public let id: Int
    public let title: String
    
    public init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}


public struct ImageRequest {
    public var id: String
}
