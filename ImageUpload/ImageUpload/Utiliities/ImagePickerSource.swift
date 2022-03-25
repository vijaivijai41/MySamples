//
//  ImagePickerSource.swift
//  ImagePickerSource
//
//  Created by Vijay on 30/10/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Photos




// Image picker delegate for custom
protocol ImagePickerDelegate: class {
    func pickerImageDelegate(didSelect image: UIImage, delegateFrom: ImagePickerSource)
    func imagePickerDelegate(didCancel delegatedFrom: ImagePickerSource)
}


class ImagePickerSource: NSObject {
    
    private weak var controller: UIImagePickerController?
    weak var delegate: ImagePickerDelegate? = nil
    
    
    /// Show Picker for image picker option
    /// - Parameter viewController: self controller
    open func showImagePicker(sourceController viewController: UIViewController)  {
        let actionSheet = UIAlertController.init(title: "Choose image souruce", message: "", preferredStyle: .actionSheet)
        let gallery = UIAlertAction(title: "Gallery", style: .default) { (action) in
            self.accessPhotoFromSource(sourceController: viewController, sourceType: .photoLibrary)
        }
        let camera = UIAlertAction(title: "Camera", style: .default) { (action) in
            CameraController.showCustomCameraView(controller: viewController) { (result) in
                switch result {
                case .success(let image):
                    self.delegate?.pickerImageDelegate(didSelect: image, delegateFrom: self)
                    
                case .failure(_):
                    break
                }
            }

        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        actionSheet.addAction(gallery)
        actionSheet.addAction(camera)
        actionSheet.addAction(cancel)
        
        viewController.present(actionSheet, animated: true, completion: nil)
    }
    
    
    private func accessPhotoFromSource(sourceController viewController: UIViewController, sourceType: UIImagePickerController.SourceType) {
        
        self.accessPermission(sourceType: sourceType) { (status) in
            if status {
                DispatchQueue.main.async {
                    if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                        let controller = UIImagePickerController()
                        controller.delegate = self
                        controller.sourceType = sourceType
                        self.controller = controller
                        viewController.present(controller, animated: true, completion: nil)
                    } else {
                        viewController.showAlert(title: "Information", message: "Your device is not supported for this feture.", okAction: nil, cancelAction: nil)
                    }                    
                }
            } else {
                DispatchQueue.main.async {
                    let strType = sourceType == .photoLibrary ? "photo library" : "Camera"
                    viewController.showAlert(title: "Access denied", message: "Please check to see if device settings doesn't allow \(strType) access", okAction: { (actionOk) in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:]) { (true) in
                            print("completion")
                        }
                    }, cancelAction: nil)
                }
            }
        }
    }
    
    public func dismiss() {
        controller?.dismiss(animated: true, completion: nil)
    }
}

extension ImagePickerSource {
    
    /// Source Type use to check permisson
    /// - Parameter viewController: parent controller
    /// - Parameter sourceType: Camera / photo gallery
    private func accessPermission(sourceType:UIImagePickerController.SourceType,completionHandler:@escaping (_ status: Bool)->()) {
        if sourceType == .camera {
            accessForCameraAccess(completionHandler: completionHandler)
        } else {
            accessForGallery(completionHandler: completionHandler)
        }
    }
    
    
    /// Access check for device
    private func accessForCameraAccess(completionHandler:@escaping (_ status: Bool)->()) {
        
        let permission = AVCaptureDevice.authorizationStatus(for: .video)
        if permission == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { (access) in
                completionHandler(access)
            }
        } else if permission == .authorized {
            completionHandler(true)
        } else {
            completionHandler(false)
        }
        
    }
    
    /// Application accss check for device
    private func accessForGallery(completionHandler: @escaping (_ status: Bool)->()) {
        let permission = PHPhotoLibrary.authorizationStatus()
        if permission == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    completionHandler(true)
                case .restricted,.denied:
                    completionHandler(false)
                default:
                    break
                }
            }
        } else if permission == .authorized {
            completionHandler(true)
        } else {
            completionHandler(false)
        }
    }
}




//MARK: UIImagePickerController extension
extension ImagePickerSource: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            delegate?.pickerImageDelegate(didSelect: image, delegateFrom: self)
            return
        }
        
        if let image = info[.originalImage] as? UIImage {
            delegate?.pickerImageDelegate(didSelect: image, delegateFrom: self)
        } else {
            print("Other source")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.imagePickerDelegate(didCancel: self)
    }
}



//MARK: UIViewController Extension
extension UIViewController {
    func showAlert(title: String? ,message: String, okAction:((UIAlertAction)->Void)? ,cancelAction: ((UIAlertAction)->())?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Settings", style: .default,handler: okAction)
        let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: cancelAction)
        
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}
