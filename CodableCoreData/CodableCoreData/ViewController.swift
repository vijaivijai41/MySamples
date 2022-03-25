//
//  ViewController.swift
//  CodableCoreData
//
//  Created by FIuser on 26/06/19.
//  Copyright © 2019 FIuser. All rights reserved.
//

import UIKit
import FundsIndiaUiKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let model = CoreDataHandler()
        
        let data = model.fetchResult()
        
        if let _data = data {
            model.saveCoreData(_data, returnClass: [Sample].self) { (result) in
                
                switch result {
                case .success(let isSuccess):
                    break
                case .failure(let error):
                    break
                }
            }
         
        }
        
        model.fetchLocalData(entityName: "Sample") { (result) in
            switch result {
            case .success(let result):
                
                let resul2 = self.assignModel(result: result)
                print(resul2)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func assignModel(result: [NSManagedObject]?)->[CoreDataObject]? {
        if let _result = result {
            let res = _result as! [Sample]
            let resu = res.compactMap { (results) -> CoreDataObject? in
                let id = results.id
                let name = results.name
                return CoreDataObject(id: id ?? "" , name: name ?? "")
            }
            return resu
        }
            return nil
    }
    


}

