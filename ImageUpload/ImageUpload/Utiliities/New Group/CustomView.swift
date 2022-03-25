//
//  CustomView.swift
//  ImageUpload
//
//  Created by Vijay on 15/11/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit

class CustomView: UIView ,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    /// PickerView ActionSheet add subview constrains
    ///
    /// - Parameter controller: AlertController
     func addConstrins(_ controller: UIAlertController) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        self.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: controller.view.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: controller.view.rightAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: self.table.contentSize.height).isActive = true
        table.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func loadNib()-> CustomView? {
        let bundle = Bundle.init(for: CustomView.self)
        let view = bundle.loadNibNamed("CustomView", owner: self, options: nil)?.first as? CustomView
        view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view?.table.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        return view
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.label.text = "\(indexPath.row)"
        return cell
    }
}


extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
