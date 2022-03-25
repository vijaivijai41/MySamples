//
//  PopOverView.swift
//  FIPopUp
//
//  Created by Vijay on 09/11/20.
//

import Foundation
import UIKit


class EQPopOverView: UIView {
    
    lazy var popOverBaseView: UIView = {
        let baseView = UIView()
        baseView.backgroundColor = UIColor.red
        baseView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return baseView
    }()
    
    lazy var customLabel: UILabel = {
        let table = UILabel(frame: self.bounds)
        table.text = ""
        table.backgroundColor = .red
        self.addSubview(table)
        return table
    }()
    
    var displayStr: String = ""
    var targetView: UIView?
    var fromView: UIView?
    var contentSize: CGSize = CGSize.zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(displayStr: String, contentSize: CGSize ,fromView: UIView?, targetView: UIView?) {
        let xAxis = UIView.convertXoriginPoint(view: fromView, contentSize: contentSize)
        let yAxis = UIView.convertYoriginPoint(view: fromView, contentSize: contentSize)
        self.init(frame: CGRect(x: xAxis , y: yAxis, width: contentSize.width, height: contentSize.height))
        self.fromView = fromView
        self.targetView = targetView
        self.contentSize = contentSize
        self.displayStr = displayStr
        
    }
    
    static func showPopUpView(fromView: UIView?, targetView: UIView?, contentSize: CGSize) {
        let popUp = EQPopOverView(displayStr: "jbsdbsabkjdbasbdkbkdsbkajkdjsbkdabdjskadbjs", contentSize: contentSize, fromView: fromView, targetView: targetView)
        popUp.tag = 1904974
        popUp.customLabel.text = popUp.displayStr
        popUp.showHide()
    }
    
    func showHide() {
        if let popUpView = self.targetView?.subviews.filter(
            { $0.tag == 1904974}).first {
            popUpView.isHidden = true
            popUpView.alpha = 0.0
            popUpView.removeFromSuperview()
            
        } else {
            self.alpha = 1.0
            self.isHidden = false
            self.addSubview(self.customLabel)
            self.targetView?.addSubview(self)
            self.fadeIn()
        }
    }
}


