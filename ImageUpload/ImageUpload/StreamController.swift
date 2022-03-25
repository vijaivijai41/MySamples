//
//  StreamController.swift
//  ImageUpload
//
//  Created by Vijay on 15/11/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit



class StreamController: UIViewController {
    
    @IBOutlet var dividerView: UIView!
    @IBOutlet weak var sortCollection: EQFilterCollectionView!
    @IBOutlet weak var filterCollection: EQFilterCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sortCollection.showFilterList(.slideOption) { (selectedindex) in
            print(selectedindex)
        }
        let selectedIndex = sortCollection.indexPathsForSelectedItems
        
        
        filterCollection.showFilterList(.selectionFilter) { (selecetedSortIndex) in
            print(selecetedSortIndex)
        }
    }
    
    @objc func normalCall() {
        print("Processing")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sortCollection = nil
        filterCollection = nil
        dividerView = nil
        print("SortView \(sortCollection)")
        print("filterView \(filterCollection)")
        print("DividerView \(dividerView)")
    }
    
    deinit {
        print(sortCollection)
        print(filterCollection)
        print(dividerView)
    }
    // Do any additional setup after loading the view.
}


