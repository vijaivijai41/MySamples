//
//  EQDrawerController.swift
//  ImageUpload
//
//  Created by Vijay on 11/12/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit


enum EQDrawerTypes {
   
    case transaction
    case buy
    case portfolio
    case addcash
    case changeInvestor
    case validation
    
    var contentSize: CGSize {
        let width = UIScreen.main.bounds.size.width
        switch self {
        case .transaction:
            return CGSize(width: width, height: 340)
        case .buy:
            return CGSize(width: width, height: 280)
        case .portfolio:
            return CGSize(width: width, height: 250)
        case .addcash:
            return CGSize(width: width, height: 250)
        case .changeInvestor:
            return CGSize(width: width, height: 250)
        case .validation:
            return CGSize(width: width, height: 240)
        }
    }
    
}


class EQDrawerController: UIPresentationController {
    
    public var drawerContentSize: CGSize = CGSize(width: 0.0, height: 0.0)
    
    /// Each and every child view frame set
    override var frameOfPresentedViewInContainerView: CGRect {
        let rect = CGRect (x: 0, y: self.containerView!.frame.size.height - self.drawerContentSize.height, width: self.drawerContentSize.width, height: drawerContentSize.height)
        return rect
    }
    
    /// Overlay view for blur effect
    private lazy var overlayView: UIView = {
        let overlay = UIView()
        overlay.isUserInteractionEnabled = true
        overlay.backgroundColor = UIColor.black
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.addGestureRecognizer(self.tapGestureRecognizer)
        return overlay
    }()
    // Tab gesture for outside tap
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(self.dismissDrawer))
    }()
    
    /// Dissmiss drawer
    @objc func dismissDrawer() {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
        
    /// Overlay view remove for end dismiss
    override public func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.overlayView.alpha = 0
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            // remove overlayView
            self.overlayView.removeFromSuperview()
        })
    }
    
    // Transition will begin
    override public func presentationTransitionWillBegin() {
        self.overlayView.alpha = 0
        // Add Overlay View
        guard let presenterView = self.containerView else { return }
        presenterView.addSubview(self.overlayView)
        
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.overlayView.alpha = 0.3
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
    }
        
    // Layout update for before show container view
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        guard let presentView = self.presentedView else { return }
        presentView.layer.masksToBounds = true
        presentView.roundCorners(corners: [.topLeft,.topRight], radius: 10)
        
    }
    
    /// Layout update add presending controller with updated frames
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        
        guard let presenterView = self.containerView else { return }
        guard let presentedView = self.presentedView else { return }
        
        // present view content
        presentedView.frame = self.frameOfPresentedViewInContainerView
        // Blur overlay view
        self.overlayView.frame = presenterView.bounds // full size
    }
    
    public static func present(source: UIViewController, child:  UIViewController, contentSize: CGSize) {
        let drawer = EQDrawerController(presentedViewController: child, presenting: source, contentSize: contentSize)
        child.transitioningDelegate = drawer
        child.modalPresentationStyle = .custom
        source.present(child, animated: true, completion: nil)
        
    }
    
    /// Override function for presenation func init with content size convenenice
    /// - Parameters:
    ///   - presentedViewController: Presented viewControler
    ///   - presentingViewController: Presenting viewController
    ///   - contentSize: Presenting view controller content size
    public convenience init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, contentSize: CGSize) {
        
        self.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.drawerContentSize = contentSize
    }
    
    /// Override function for presenation func init with content size convenenice
    /// - Parameters:
    ///   - presentedViewController: Presented viewControler
    ///   - presentingViewController: Presenting viewController
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
}


// Custom present function for UIViewController
extension UIViewController {
    func presentDrawer(presentingController: UIViewController, contentSize: CGSize) {
        let drawer = EQDrawerController(presentedViewController: presentingController, presenting: self, contentSize: contentSize)
        presentingController.transitioningDelegate = drawer
        presentingController.modalPresentationStyle = .custom
        self.present(presentingController, animated: true, completion: nil)
    }
}



extension EQDrawerController : UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return EQDrawerController(presentedViewController: presented, presenting: presented,contentSize: self.drawerContentSize)
    }
    
}


private extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
