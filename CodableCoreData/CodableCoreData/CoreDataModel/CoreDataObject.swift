//
//  CoreDataObject.swift
//  CodableCoreData
//
//  Created by FIuser on 26/06/19.
//  Copyright © 2019 FIuser. All rights reserved.
//

import UIKit



struct CoreDataObject : Codable {
    var id: String
    var name: String

}


//
//  CoreDataObject.swift
//  CodableCoreData
//
//  Created by FIuser on 26/06/19.
//  Copyright © 2019 FIuser. All rights reserved.
//

import UIKit



protocol BaseClaasProtocal {
    var code: Int { get }
    var desc: String { get }
    var all_data: Any { get }
}

struct DataModel : Codable {
    let mi: String
    let cc: String
    let cn: String
    
    
}


