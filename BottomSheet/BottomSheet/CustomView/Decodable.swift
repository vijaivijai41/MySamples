//
//  Decodable.swift
//  FundsIndiaApp
//
//  Created by Sasikumar JP on 10/03/19.
//  Copyright © 2019 FundsIndia. All rights reserved.
//

import Foundation

extension Decodable {
    
    public static func modelObject(fromJsonString jsonString: String) -> Self? {
        let jsonDecoder = JSONDecoder()
        print("JSON String before parsing: \(jsonString)")
        let jsonUpdatedString = jsonString.replacingOccurrences(of: "'", with: "\"").replacingOccurrences(of: "“", with: "\"").replacingOccurrences(of: "”", with: "\"")
        if let data = jsonUpdatedString.data(using: .utf8) {
            do {
                return try jsonDecoder.decode(self, from: data)
            } catch {
                do {
                    if let obj = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? String {
                        return try jsonDecoder.decode(self, from: obj.data(using: .utf8)!)
                    }
                } catch {
                    print("JSON Parsing Error: \(error)")
                }
            }
        }
        return nil
    }
    
    public static func modelObject(fromJSONData jsonData: Data) -> Self? {
        let jsonString = String(decoding: jsonData, as: UTF8.self)
        return modelObject(fromJsonString: jsonString)
    }
}
