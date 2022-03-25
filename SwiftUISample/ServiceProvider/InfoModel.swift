//
//  InfoModel.swift
//  ServiceProvider
//
//  Created by Vijay on 19/08/20.
//

import Foundation

public struct InfoModel: Codable {
    public let id: Int
    public let title: String
    
    public init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}

