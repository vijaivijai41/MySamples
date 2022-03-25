//
//  PopOverPresentataion.swift
//  FIPopUp
//
//  Created by Vijay on 09/11/20.
//

import UIKit

class PopOverPresentataion: UIPresentationController {

    
    var contentSize: CGSize = CGSize.zero
    
    var barButton: UIBarButtonItem?
    
    var fromView: UIView?
    
    override var frameOfPresentedViewInContainerView: CGRect {
        return CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
    }
    
    lazy var overlayView: UIView = {
        let table = UIView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        table.backgroundColor = .red

        return table
    }()
    
    
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
        guard let presentedView = self.presentedView else { return }
        presentedView.frame = frameOfPresentedViewInContainerView

        presentedView.layer.masksToBounds = true
    }
        
    /// Layout update add presending controller with updated frames
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        
        guard let presenterView = self.containerView else { return }
        guard let presentedView = self.presentedView else { return }
        presentedView.backgroundColor = .white
        // present view content
        presentedView.frame = frameOfPresentedViewInContainerView
    
        // Blur overlay view
        self.overlayView.frame = presenterView.bounds // full size
        
    }

    
    convenience  init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, contentSize: CGSize, sourceView: UIView?, barbuttonItem: UIBarButtonItem?) {
        self.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.contentSize = contentSize
        self.barButton = barbuttonItem
        self.fromView = sourceView
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
    }
}


extension PopOverPresentataion: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PopOverPresentataion(presentedViewController: presentedViewController, presenting: presenting, contentSize: self.contentSize, sourceView: self.fromView, barbuttonItem: self.barButton)
    }
}


extension PopOverPresentataion: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        if traitCollection.horizontalSizeClass == .compact {
            return UIModalPresentationStyle.none
            //return UIModalPresentationStyle.fullScreen
        }
        //return UIModalPresentationStyle.fullScreen
        return UIModalPresentationStyle.none
    }

    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        return controller.presentedViewController
    }
}


extension UIViewController {
    
    func showPopUp(fromController: UIViewController, fromView: UIView?, barButton: UIBarButtonItem?, contentSize: CGSize) {
        let controller = PopOverPresentataion(presentedViewController: self, presenting: self, contentSize: contentSize, sourceView: fromView, barbuttonItem: barButton)
        
        self.transitioningDelegate = controller
        self.modalPresentationStyle = UIModalPresentationStyle .popover
        
        self.preferredContentSize = contentSize
        self.popoverPresentationController?.delegate = controller
        self.popoverPresentationController?.permittedArrowDirections = .unknown
        if barButton !=  nil {
            self.popoverPresentationController?.barButtonItem = barButton
        } else {
            self.popoverPresentationController?.sourceView = fromView
            self.popoverPresentationController?.sourceRect = fromView?.bounds ?? CGRect.zero
        }
        fromController.present(self, animated: true, completion: nil)

    }
}



