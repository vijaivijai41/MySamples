//
//  ViewController.swift
//  VlaidationSample
//
//  Created by Vijay on 01/08/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var eail: FITextField!
    @IBOutlet weak var passwordTxt: FITextField!
    @IBOutlet weak var mobileTxt: FITextField!
    
    let validate = Validate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addValidation()
        
        // Do any additional setup after loading the view.
    }

    
    func addValidation() {
        let email = FieldValidate(type: .email, fields: eail, isRequire: true)
        let password = FieldValidate(type:.password, fields: passwordTxt, isRequire: true)
        let mobile = FieldValidate(type:.mobile, fields: mobileTxt, isRequire: true)
        validate.addValidate(validationSource: [email,password,mobile])
    }
    @IBAction func validateButtonDidTap(_ sender: Any) {
        
        self.performSegue(withIdentifier: "identifier", sender: self)
        
        if validate.isSuccess {
            print("validationSuccess")
        }
        
    }
    
}

