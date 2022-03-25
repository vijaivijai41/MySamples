//
//  EQFilterCollectionView.swift
//  ImageUpload
//
//  Created by Vijay on 27/11/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import UIKit


protocol FilterProtocal {
    var arrayElemets: [String] { get }
}

enum FilterSource : FilterProtocal {
    
    case selectionFilter
    case slideOption
    
    var arrayElemets: [String] {
        switch self {
        case .selectionFilter:
            return ["ALL","BSE","NSE"]
        case .slideOption:
            return ["A->Z","LTP","%Change↑"]
        }
    }
}


typealias SelectedElementsHandler = (_ selectedIndex: Int) -> ()
class EQFilterCollectionView: UICollectionView {
    var contentDataSource: FilterSource? = nil
    var selectedHandler: SelectedElementsHandler? = nil
    var filterElements: [String] = []
    var selecteFilterItem: [IndexPath] = [IndexPath(item: 0, section: 0)]
    var selecteSortItem: Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        self.register(UINib(nibName: "FilterViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterViewCell")
        self.register(UINib(nibName: "EQWatchlistSortCell", bundle: nil), forCellWithReuseIdentifier: "EQWatchlistSortCell")

        self.delegate = self
        self.dataSource = self
    }
    
    func showFilterList(_ dataSource: FilterSource, onSelected: SelectedElementsHandler?) {
        filterElements = dataSource.arrayElemets
        self.contentDataSource = dataSource
        self.reloadData()
    }
    
}

extension EQFilterCollectionView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.filterElements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch contentDataSource {
        case .selectionFilter:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterViewCell", for: indexPath) as! FilterViewCell
            cell.elementLabel.text = filterElements[indexPath.item]
            
            if selecteFilterItem.contains(indexPath) {
                cell.selectedFilterCell(true)
            } else {
                cell.selectedFilterCell(false)
            }
            return cell
        case .slideOption :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EQWatchlistSortCell", for: indexPath) as! EQWatchlistSortCell
            cell.elamentLabel.text = filterElements[indexPath.item]
            
            if selecteSortItem == indexPath.item {
                cell.selectedSortCell(true)
            } else {
                cell.selectedSortCell(false)
            }
            return cell
            
            
        default:
            let cell = UICollectionViewCell()
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = filterElements[indexPath.item]
        label.sizeToFit()
        return CGSize(width: label.frame.size.width + 40, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch contentDataSource {
        case .selectionFilter:
            if indexPath.item == 0 {
                selecteFilterItem.removeAll()
                selecteFilterItem.append(indexPath)
            } else {
                selecteFilterItem = selecteFilterItem.filter { $0.item != 0}
                selecteFilterItem.append(indexPath)
            }
            selectedHandler?(indexPath.item)
        case .slideOption:
            selecteSortItem = indexPath.item
            
        case .none:
            break
        }
        
        collectionView.reloadData()
        
    }
}





