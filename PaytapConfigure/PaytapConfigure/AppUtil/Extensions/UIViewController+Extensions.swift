//
//  UIViewController+Extensions.swift
//  PaytapConfigure
//
//  Created by Vijay on 10/06/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    func showAlert(message: String, okButtonAction:((UIAlertAction)->())?) {
        let alert = UIAlertController(title: "Information", message: message, preferredStyle: .alert)
        let okButtonAction = UIAlertAction(title: "Ok", style: .default, handler: okButtonAction)
        
        alert.addAction(okButtonAction)
        self.present(alert, animated: true, completion: nil)
    }
}
