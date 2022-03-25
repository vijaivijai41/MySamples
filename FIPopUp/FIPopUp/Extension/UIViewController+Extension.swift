//
//  UIViewController+Extension.swift
//  FIPopUp
//
//  Created by Vijay on 09/11/20.
//

import Foundation
import UIKit



extension UIViewController {
    var topSafeArea: CGFloat {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets.top
        } else {
            return topLayoutGuide.length
        }
    }
    var bottomSafeArea: CGFloat {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets.bottom
        } else {
            return  bottomLayoutGuide.length
        }
    }
    
    func fetchExactView(barbutton: UIBarButtonItem) -> UIView? {
        if let view = barbutton.value(forKey: "view") as? UIView {
            let viewFrame = view.frame
            let actualPointOnWindow = view.convert(view.frame.origin, to: nil)
            return  UIView(frame: CGRect(x: actualPointOnWindow.x, y: view.frame.origin.y + self.topSafeArea, width: viewFrame.width, height: viewFrame.height))
        }
        return nil
    }
}

