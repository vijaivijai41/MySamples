//
//  ChartToolView.swift
//  FICommon
//
//  Created by Vijay on 30/06/21.
//  Copyright © 2020 FundsIndia. All rights reserved.
//

import Foundation
import UIKit


enum FIToolTipPosition {
    case topLeft
    case topRight
}

public class FIChartToolView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    var borderColor: UIColor!
    var bgColor: UIColor!
    var sourceView: UIView!
    var currentPoint: CGPoint!
    var message: String!
    var arrowPosition: FIToolTipPosition!
    private let arrowWidth: CGFloat = 10
    private let arrowHeight: CGFloat = 10
    
    private let toolTipHeight: CGFloat = 60
    private let toolTipWidth: CGFloat = 100
    
    public static func showToolTipView(soureView: UIView, currentPoint: CGPoint, message: String, borderColor: UIColor, bgColor: UIColor) {
        if let toolView = FIChartToolView.loadView() {
            toolView.sourceView = soureView
            toolView.currentPoint = currentPoint
            toolView.message = message
            toolView.borderColor = borderColor
            toolView.bgColor = bgColor

            if let foundView = soureView.viewWithTag(1010101) {
                foundView.removeFromSuperview()
            }
            
            toolView.tag = 1010101
            soureView.addSubview(toolView)
            toolView.findArrowCurrectPosition(currentpoint: currentPoint, sourceView: soureView)
            toolView.showArrowTail()
            toolView.messgaeLabel.text = message
            toolView.messgaeLabel.backgroundColor = bgColor
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                
                if let foundView = soureView.viewWithTag(1010101) {
                    foundView.removeFromSuperview()
                }
            }
        }
    }
    
    private func findArrowCurrectPosition(currentpoint: CGPoint, sourceView: UIView) {
        if currentPoint.x > self.sourceView.bounds.size.width/2 {
            self.arrowPosition = .topLeft
        } else {
            self.arrowPosition = .topRight
        }
    }
    
    private static func loadView() -> FIChartToolView? {
        return FIChartToolView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private lazy var messageBaseView: UIView = {
        let message = UIView()
        message.backgroundColor = .clear
        message.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(message)
        return message
    }()
    
    private lazy var messgaeLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = MFColor.mfLightLabel
        messageLabel.font = UIFont.systemFont(ofSize: 12)
        messageLabel.layer.cornerRadius = 10.0
        messageLabel.numberOfLines = 0
        messageLabel.layer.masksToBounds = true
        messageLabel.textAlignment = .center
        
        self.messageBaseView.addSubview(messageLabel)
        
        return messageLabel
    }()
    
    private func showArrowTail() {
        let tailPath = getTailPath()
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillRule = .evenOdd
        shapeLayer.fillColor = self.bgColor.cgColor
        shapeLayer.path = tailPath
        shapeLayer.lineWidth = 1.0
        shapeLayer.strokeColor = self.borderColor.cgColor
        self.messageBaseView.layer.addSublayer(shapeLayer)
    }
    
    /// Draw box with arrow
    private func getTailPath() -> CGPath {
        let bezier = UIBezierPath()
        bezier.move(to: CGPoint(x: 0, y: 0))
        bezier.addLine(to: CGPoint(x: toolTipWidth, y: 0))
        bezier.addLine(to: CGPoint(x: toolTipWidth, y: toolTipHeight))

        // Draw arrow
        switch self.arrowPosition {
        case .topRight:
            bezier.addLine(to: CGPoint(x: arrowWidth , y: toolTipHeight))
            bezier.addLine(to: CGPoint(x: arrowWidth - (arrowWidth/2), y: arrowHeight + toolTipHeight))
            bezier.addLine(to: CGPoint(x: 0, y: toolTipHeight))
        default:
            bezier.addLine(to: CGPoint(x: toolTipWidth , y: toolTipHeight))
            bezier.addLine(to: CGPoint(x: toolTipWidth - (arrowWidth/2), y: arrowHeight + toolTipHeight))
            bezier.addLine(to: CGPoint(x: toolTipWidth - arrowWidth, y: toolTipHeight))
        }
        bezier.addLine(to: CGPoint(x: 0, y: toolTipHeight))
        bezier.close()
        bezier.fill()
        return bezier.cgPath
    }
    
    private func setBaseConstraints() {
        let leadingConstant: CGFloat    =  (currentPoint.x > self.sourceView.bounds.size.width/2) ? currentPoint.x - toolTipWidth : currentPoint.x
        
        let topConstant: CGFloat =  (sourceView.bounds.size.height > (currentPoint.y + toolTipHeight)) ? currentPoint.y - (toolTipHeight + arrowHeight) : currentPoint.y - toolTipHeight
      
        self.messageBaseView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConstant).isActive = true
        self.messageBaseView.topAnchor.constraint(equalTo: topAnchor,constant: topConstant).isActive = true
                                
        self.messgaeLabel.leadingAnchor.constraint(equalTo: messageBaseView.leadingAnchor,constant: 1.0).isActive = true
        self.messgaeLabel.trailingAnchor.constraint(equalTo: messageBaseView.trailingAnchor, constant: -1.0).isActive = true
        self.messgaeLabel.topAnchor.constraint(equalTo: messageBaseView.topAnchor, constant: 1.0).isActive = true
        self.messgaeLabel.bottomAnchor.constraint(equalTo: messageBaseView.bottomAnchor, constant: -1.0).isActive = true
        self.messgaeLabel.heightAnchor.constraint(equalToConstant: toolTipHeight-2).isActive = true
        self.messgaeLabel.widthAnchor.constraint(equalToConstant: toolTipWidth-2).isActive = true
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.setBaseConstraints()
        self.addDropShadowWithRoundedCorner(cornerRadius: 10)
    }
}




extension UIView {
    
    func addToolTipView(currentPoint: CGPoint,selectedPointWith x: String, y: String) {
        FIChartToolView.showToolTipView(soureView: self, currentPoint: currentPoint, message: "x:\(x) This Scheme: \(y)", borderColor: UIColor(red: 0.16, green: 0.72, blue: 0.91, alpha: 1.00), bgColor: UIColor(red: 0.70, green: 0.89, blue: 0.96, alpha: 1.00))
        
    }
}
    
