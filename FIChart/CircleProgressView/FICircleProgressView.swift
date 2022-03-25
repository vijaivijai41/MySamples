//
//  CircleProgressView.swift
//  ChartSample
//
//  Created by Vijay on 01/07/21.
//

import Foundation
import UIKit


import Foundation
import UIKit


public class FICircleProgressView: UIView {
    
    // First create two layer properties
    
    private var progressLineWidth = 5.0
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func showFICircleProgress(bgColor: UIColor, progressColor: UIColor, progressValue: CGFloat) {
        self.createCicularPath(bgColor: bgColor, progressColor: progressColor, progressValue: progressValue)
        self.progressAnimation(duration: 0.5, progressValue: progressValue)
    }
    
    private func createCicularPath(bgColor: UIColor, progressColor: UIColor, progressValue: CGFloat) {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: frame.size.width/2, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = bgColor.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 0.0
        circleLayer.strokeColor = bgColor.cgColor
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = progressLineWidth
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = progressColor.cgColor
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
        
    }
    private func progressAnimation(duration: TimeInterval, progressValue: CGFloat) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = progressValue
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}
