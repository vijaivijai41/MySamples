//
//  BaseController.swift
//  SplitControllerSample
//
//  Created by FIuser on 01/07/19.
//  Copyright © 2019 FundsIndia. All rights reserved.
//

import UIKit

var isSplited = false

class BaseController: UIViewController,UISplitViewControllerDelegate {
    
    static var viewController : UISplitViewController!
    var isMenuShow: Bool = false
    static var isShow: Bool = false
    var newTrail: UITraitCollection? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    /// load Controller
    ///
    /// - Returns: return basecontroller
    class func loadController() -> BaseController? {
        return BaseController()
    }
    
    /// Embeded controller
    ///
    /// - Parameter splitViewController: split controller
    class func setEmbeddedViewController(splitViewController: UISplitViewController!) -> BaseController? {
        if let controller = BaseController.loadController() {
            if splitViewController != nil {
                BaseController.viewController = splitViewController
                controller.addChild(BaseController.viewController)
                controller.view.addSubview(BaseController.viewController.view)
                BaseController.viewController.didMove(toParent: controller)
                
                if controller.isSplit {
                    controller.changeMode(collection: controller.traitCollection)
                } else {
                    controller.changeMode(collection: UIScreen.main.traitCollection)
                }
            }
            return controller
        }
        return nil
    }
    
    /// Change Trait mode to update view
    ///
    /// - Parameter collection: TraitCollection
    func changeMode(collection: UITraitCollection?) {
        if collection?.horizontalSizeClass == .regular {
            BaseController.viewController?.preferredDisplayMode = UISplitViewController.DisplayMode.allVisible
        } else {
            self.setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: UIUserInterfaceSizeClass.regular), forChild: BaseController.viewController)
            BaseController.viewController?.preferredDisplayMode = UISplitViewController.DisplayMode.primaryHidden
        }
    }
    
    /// Add Left Button class
    ///
    /// - Parameters:
    ///   - image: Button image
    ///   - selector: @selector action
    func addLeftMenuButton(title: String?,image: UIImage?,selector: Selector?) {
        if isMenuShow && isSplit {
            let barbutton = UIBarButtonItem.init(image: image, style:.done, target: self, action: selector)
            barbutton.title = title
            self.navigationItem.setLeftBarButton(barbutton, animated: true)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        print("Trait collection change notification")
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if newTrail == nil {
            if self.traitCollection.horizontalSizeClass == .compact || isSplit {
                isSplited = true
            }
        }
        newTrail = newCollection
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if size.width < UIScreen.main.bounds.size.width {
            isSplited = true
            self.changeMode(collection: newTrail)
        } else {
            isSplited = false
            self.changeMode(collection: UIScreen.main.traitCollection)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "SplitChangesNotification"), object: nil)
    }
    
    /// Button action for is Swipe right and left
    func showHideSplitView() {
        if BaseController.isShow == false {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
                self.splitViewController?.preferredDisplayMode = UISplitViewController.DisplayMode.primaryOverlay
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
                self.splitViewController?.preferredDisplayMode = UISplitViewController.DisplayMode.primaryHidden
            }, completion: nil)
        }
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        
        topAsDetailController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        topAsDetailController.navigationItem.leftItemsSupplementBackButton = true
        
        return false
    }
    
}


// MARK: - Check is Splited or not
extension UIViewController {
    
    var isSplit : Bool {
        get {
            if UIScreen.main.traitCollection.horizontalSizeClass == .regular {
                if self.view.bounds.size.width < UIScreen.main.bounds.size.width {
                    return true
                }
            } else {
                return true
            }
            return false
        }
    }
}
