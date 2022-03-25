//
//  CoreDataHandler.swift
//  CodableCoreData
//
//  Created by FIuser on 26/06/19.
//  Copyright © 2019 FIuser. All rights reserved.
//

import UIKit
import CoreData
import Foundation

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class CoreDataHandler: NSObject {

    private lazy var privateManagedObjectContext: NSManagedObjectContext = {
        // Initialize Managed Object Context
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        // Configure Managed Object Context
        managedObjectContext.persistentStoreCoordinator = appDelegate.persistentContainer.persistentStoreCoordinator
        
        return managedObjectContext
    }()
    
    private lazy var mainManagedObjectContext: NSManagedObjectContext = {
       
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = appDelegate.persistentContainer.persistentStoreCoordinator
        return managedObjectContext
        
    }()
    
    
    func fetchResult() -> Data? {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
               
                return data
            } catch {
                // handle error
                return nil
            }
        }
        return nil
    }
    
    
    func saveCoreData<T: Codable>(_ results:Data,returnClass: T.Type, completionHandler:(Result<Bool,Error>)->()) {
        do {
            guard let codableContext = CodingUserInfoKey.init(rawValue: "context") else {
                fatalError("Failed context")
            }
            let decoder = JSONDecoder()
            decoder.userInfo[codableContext] = privateManagedObjectContext
            // Parse JSON data
            _ = try decoder.decode(returnClass.self, from: results)
            do {
                try privateManagedObjectContext.save()
                completionHandler(.success(true))
            } catch {
                completionHandler(.failure(error))
            }
        }catch {
            completionHandler(.failure(error))
        }
    }
    
    ///Local data fetch from core data
    func fetchLocalData<T: NSManagedObject>(entityName:String,completionHandler:(Result<[T],Error>)->()){
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        ///Sort by id
       
        do {
           let result = try privateManagedObjectContext.fetch(fetchRequest)
            return completionHandler(.success(result))
        } catch let error {
            return completionHandler(.failure(error))
        }
    }
}
