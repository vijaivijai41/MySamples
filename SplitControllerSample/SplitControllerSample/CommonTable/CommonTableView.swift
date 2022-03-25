//
//  CommonTableView.swift
//  SplitControllerSample
//
//  Created by FIuser on 03/07/19.
//  Copyright © 2019 FundsIndia. All rights reserved.
//

import UIKit

typealias DidSelectionHandler = (_ indexPath: IndexPath) -> ()


class CommonTableView: UITableView,UITableViewDataSource,UITableViewDelegate {
   
    override func awakeFromNib() {
        dataSource = self
        delegate = self
    }
    
    public var cell: UITableViewCell = UITableViewCell()
    public var cellIdentifier : String = ""
    public var selectionIdentifier: DidSelectionHandler?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = cellIdentifier
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionIdentifier?(indexPath)
    }
}

