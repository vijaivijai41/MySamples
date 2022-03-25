//
//  Sample+CoreDataProperties.swift
//  CodableCoreData
//
//  Created by FIuser on 26/06/19.
//  Copyright © 2019 FIuser. All rights reserved.
//
//

import Foundation
import CoreData


extension Sample {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sample> {
        return NSFetchRequest<Sample>(entityName: "Sample")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?

}
