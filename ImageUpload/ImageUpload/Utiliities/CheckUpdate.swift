//
//  CheckUpdate.swift
//  ImageUpload
//
//  Created by Vijay on 29/11/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import UIKit

// Check update protocal
protocol UpdateErrorProtocal {
    var errorString: String { get }
}

// Update error message
enum UpdateError:UpdateErrorProtocal, Error {
    case invalidBundle
    case invalidResponse
    
    var errorString: String {
        switch self {
        case .invalidBundle:
            return "Invalid bundleIdentifier"
        case .invalidResponse:
            return "Invalid bundle response"
        }
    }
}


final class CheckUpdate {
    var appStoreUrl: String?
  
    // is update available
    func isUpdateAvailable() throws -> Bool {
        guard let appInfoDict = Bundle.main.infoDictionary, let currentVersion = appInfoDict["CFBundleShortVersionString"]as? String ,let bundleIdentifier = appInfoDict["CFBundleIdentifier"] as? String ,let appUrl = URL(string: "http://itunes.apple.com/lookup?bundleId=\(bundleIdentifier)") else {
            
            throw UpdateError.invalidBundle
        }
        let data = try Data(contentsOf: appUrl)
        
        guard let reponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw UpdateError.invalidResponse
        }
        
        if let resultData = (reponse["results"] as? [Any])?.first as? [String: Any], let version = resultData["version"] as? String {
            appStoreUrl = resultData["trackViewUrl"] as? String
            return version != currentVersion
        }
        
        throw UpdateError.invalidResponse
    }
    
    // force update boolean
    static var forceUpdate: Bool = false {
        didSet {
            do {
                let model = CheckUpdate()
                let isAvailable = try model.isUpdateAvailable()
                if isAvailable {
                    DispatchQueue.main.async {
                        model.showAlert(isForce: forceUpdate)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // is Show desclimer viee
    static var isShowDisclimer: Bool = false {
        didSet {
            let model = CheckUpdate()
            DispatchQueue.main.async {
                model.showAlert(isForce: true)
            }
        }
    }
    
    /// Load disclimer view components
    /// - Parameter isShowCloseButton: is shown close button
    func loadDisclimerView(isShowCloseButton: Bool) {
        
        let aler = UIAlertController(title: nil, message: "", preferredStyle: .alert)
        if let disclimerView = DesclimerView.loadView() {
            disclimerView.closeButton.isHidden = !isShowCloseButton
            disclimerView.frame = aler.view.bounds
            //disclimerView.center = aler.view.convert(aler.view.center, from:aler.view.superview)
            disclimerView.textView.text = "fdfbdsfkbdkfbkdsbfkjdbkfbdsjfbkdbfksbkjfbdkjbfksjdbfkjdbkfjbdjbfkjbdkjfbjkdsbfjkbdskjbfkjdbfksj"
            disclimerView.textViewHeightConstrains.constant = 200
            aler.view.addSubview(disclimerView)
        }
        
        UIApplication.topViewController()?.present(aler, animated: true, completion: nil)

        
    }
    
    // Show alert view
    func showAlert(isForce: Bool) {
        let title = "New version available"
        let message = "There is a newer version available for download! Please update the app by visiting the Apple store"
        let updateAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let updateAction = UIAlertAction(title: "Update Now", style: .default) { (updateAction) in
            let ituneUrl =  "itms-apps://itunes.apple.com/in/app/fundsindia/id1047151768?uo=4"
            if let url = URL(string: ituneUrl) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Remind Me Later", style: .default) { (cancelAction) in
        }

        updateAlert.addAction(updateAction)
        if !isForce {
            updateAlert.addAction(cancelAction)
        }
        UIApplication.topViewController()?.present(updateAlert, animated: true, completion: nil)
    }
    
    deinit {
        print("de-initialize Checkupdate class")
    }
}




extension UIApplication {
    class func topViewController(controller: UIViewController? = UIViewController()) -> UIViewController? {

        for scene in UIApplication.shared.connectedScenes {
            if scene.activationState == .foregroundActive {
                return ((scene as? UIWindowScene)!.delegate as! UIWindowSceneDelegate).window!!.rootViewController
            }
        }
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}



class EQSpanSymbolSearchCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated:animated)
    }
}



class EQSpanCalclaterSearchTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var selectionHandler: ((_ indexPath: IndexPath) ->())? = nil
    public var searchList: [String] = [String]() {
        didSet {
            self.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        self.register(EQSpanSymbolSearchCell.self, forCellReuseIdentifier: "EQSpanSymbolSearchCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: "EQSpanSymbolSearchCell", for: indexPath) as! EQSpanSymbolSearchCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHandler?(indexPath)
    }
    
}


