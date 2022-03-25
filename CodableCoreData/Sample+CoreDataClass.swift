//
//  Sample+CoreDataClass.swift
//  CodableCoreData
//
//  Created by FIuser on 26/06/19.
//  Copyright © 2019 FIuser. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Sample)
public class Sample: NSManagedObject,Codable {

    // MARK: - Codable setUp
    enum CodingKeys: String, CodingKey {
        case name
        case id
    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        
        ///Fetch context for codable
        guard let codableContext = CodingUserInfoKey.init(rawValue: "context"),
            let manageObjContext = decoder.userInfo[codableContext] as? NSManagedObjectContext,
            let manageObjList = NSEntityDescription.entity(forEntityName: "Sample", in: manageObjContext) else {
                fatalError("failed")
        }
        
        self.init(entity: manageObjList, insertInto: manageObjContext)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
       
        id = try values.decode(String.self, forKey:.id)
        
    }
    // MARK: - Encoding the data
    
    public func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(name, forKey: .name)
            try container.encode(id, forKey: .id)
        } catch {
            print(error.localizedDescription)
        }
        
    }

    
}
