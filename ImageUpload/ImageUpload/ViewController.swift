//
//  ViewController.swift
//  ImageUpload
//
//  Created by Vijay on 30/10/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var imagePicker = ImagePickerSource()

    @IBOutlet weak var baseIimageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(settingChanged(notification:)), name: UserDefaults.didChangeNotification, object: nil)
        if let controller =  EQPDFViewController.showPdf(controller: self, pdfUrl: "jenish_3.0.pfg") {
            self.addChildController(controller: controller)

        }
        
        // Do any additional setup after loading the view.
    }
    
    func addChildController(controller: UIViewController) {
           self.addChild(controller)

           //make sure that the child view controller's view is the right size
           controller.view.frame = self.view.bounds
           self.view.addSubview(controller.view)

           //you must call this at the end per Apple's documentation
           controller.didMove(toParent: self)
       }
    
    @objc func settingChanged(notification: NSNotification) {
        if let defaults = notification.object as? UserDefaults {
            if defaults.bool(forKey: "enabled_preference") {
                print("enabled_preference set to ON")
            }
            else {
                print("enabled_preference set to OFF")
            }
        }
    }

    @IBAction func chooseImageButtonDidTap(_ sender: UIButton) {
        imagePicker.showImagePicker(sourceController: self)
    }
    
}

extension ViewController: ImagePickerDelegate {
    func pickerImageDelegate(didSelect image: UIImage, delegateFrom: ImagePickerSource) {
        baseIimageView.image = image.qualityImage(quality: .low)
        imagePicker.dismiss()
    }

    func imagePickerDelegate(didCancel delegatedForm: ImagePickerSource) {
        imagePicker.dismiss()
    }

}
