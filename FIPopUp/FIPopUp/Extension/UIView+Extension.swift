//
//  UIView+Extension.swift
//  FIPopUp
//
//  Created by Vijay on 09/11/20.
//

import Foundation
import UIKit
 

extension UIView {
    
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static func convertXoriginPoint(view: UIView?, contentSize: CGSize) -> CGFloat {
        if (view?.frame.origin.x ?? 0) + contentSize.width > UIView.screenWidth {
            let content = ((view?.frame.origin.x ?? 0) + contentSize.width) - UIView.screenWidth
            return (view?.frame.origin.x ?? 0) - (content + 20)
        } else {
            return view?.frame.origin.x ?? 0
        }
        
    }
    
    static func convertYoriginPoint(view: UIView?, contentSize: CGSize) -> CGFloat {
        let viewHeight = view?.frame.size.height ?? 0
        let viewCenterY = view?.center.y ?? 0
        if viewCenterY + viewHeight + contentSize.height > UIView.screenHeight {
            return viewCenterY - viewHeight/2 - contentSize.height
        } else {
            return (view?.frame.maxY ?? 0)
        }
    }
    
    
    func fadeIn(duration: TimeInterval = 0.5,
                delay: TimeInterval = 0.0,
                completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseOut,
                       animations: {
                        self.alpha = 1.0
                       }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.5,
                 delay: TimeInterval = 0.0,
                 completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut) {
            self.alpha = 0.0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
    
    func pulse(withIntensity intensity: CGFloat, withDuration duration: Double, loop: Bool) {
        //        UIView.animate(withDuration: duration, delay: 0, options: [.repeat, .autoreverse], animations: {
        //            loop ? nil : UIView.setAnimationRepeatCount(1)
        //            self.transform = CGAffineTransform(scaleX: intensity, y: intensity)
        //        }) { (true) in
        //            self.transform = CGAffineTransform.identity
        //        }
        
        UIView.animate(withDuration: 0.3, animations: {
            DispatchQueue.main.async {
                self.center.x += 100
                self.frame.size.width = 200
            }
        }, completion: { _ in
            self.backgroundColor = .red
        })
    }
}






