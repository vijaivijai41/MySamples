//
//  OTPTextfield.swift
//  ImageUpload
//
//  Created by Vijay on 20/01/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import Foundation
import UIKit



class OTPTextfield: UIView {
    
    var otpLength: Int = 4
    
    var otpTextField: UITextField {
        let field = UITextField()
        var xaxis = self.leadingAnchor
        for item in 0..<otpLength {
            
            let view = field
            view.tag = (item+1) * 100
            view.delegate = self
            self.addSubview(view)
            view.backgroundColor = UIColor.red
            view.translatesAutoresizingMaskIntoConstraints = false
            view.leadingAnchor.constraint(equalTo: xaxis,constant: 10).isActive = true
            view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            // view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0).isActive = true
            xaxis = view.trailingAnchor
            self.trailingAnchor.constraint(equalTo: xaxis, constant: 20).isActive = true
        }
        
        return field
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    func setUpView() {
        self.otpTextField.delegate = self
        otpTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        self.addSubview(self.otpTextField)
    }
    
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if  text?.count == 1 {
            switch textField.tag{
            case 100:
                let tagField = self.viewWithTag(100)
                tagField?.becomeFirstResponder()
            case 200:
                let tagField = self.viewWithTag(200)
                tagField?.becomeFirstResponder()
            case 300:
                let tagField = self.viewWithTag(300)
                tagField?.becomeFirstResponder()
            case 400:
                let tagField = self.viewWithTag(400)
                tagField?.becomeFirstResponder()
            default:
                break
            }
        }
        if  text?.count == 0 {
            switch textField.tag {
            case 100:
                let tagField = self.viewWithTag(100)
                tagField?.becomeFirstResponder()
            case 200:
                let tagField = self.viewWithTag(300)
                tagField?.becomeFirstResponder()
            case 300:
                let tagField = self.viewWithTag(300)
                tagField?.becomeFirstResponder()
            case 400:
                let tagField = self.viewWithTag(400)
                tagField?.becomeFirstResponder()
            default:
                break
            }
        }
        else{
            
        }
    }
}

extension OTPTextfield: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    
}
