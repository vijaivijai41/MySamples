//
//  ViewController.swift
//  FlutterCombine
//
//  Created by Vijay on 02/06/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit
import Flutter

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make a button to call the showFlutter function when pressed.
        let button = UIButton(type:UIButton.ButtonType.custom)
        button.addTarget(self, action: #selector(showFlutter), for: .touchUpInside)
        button.setTitle("Show Flutter!", for: UIControl.State.normal)
        button.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
        button.backgroundColor = UIColor.blue
        self.view.addSubview(button)
        // Do any additional setup after loading the view.
    }
    
    @objc func showFlutter() {
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        let flutterViewController =
            FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        
        let channel = FlutterMethodChannel(name: "survey_channel", binaryMessenger: flutterViewController.binaryMessenger)
        
        channel.invokeMethod("prepare", arguments: "Vijaya kumar")
        
        channel.setMethodCallHandler { [weak self] call, result in
            
            switch call.method {
            case "close":
                self?.dismiss(animated: true, completion: nil)
                result(nil)
            default:
                
                result(FlutterMethodNotImplemented)
            }
        }
        
        present(flutterViewController, animated: true, completion: nil)
    }
}

