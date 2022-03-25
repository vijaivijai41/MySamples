//
//  JSONDecodable.swift
//  FundsIndiaApp
//
//  Created by Sasikumar JP on 10/03/19.
//  Copyright © 2019 FundsIndia. All rights reserved.
//

import Foundation

protocol JSONDecodable {
    static func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecodable {
    static func decode<T:Decodable>(_ type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        let response = try decoder.decode(type, from: data)
        return response
    }
}
