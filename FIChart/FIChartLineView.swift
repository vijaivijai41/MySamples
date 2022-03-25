//
//  LineView.swift
// FICommon
//
//  Created by Vijay on 25/06/21.
//  Copyright © 2020 FundsIndia. All rights reserved.
//

import Foundation
import UIKit


func calculatePointsSpace(x: Int, y: Int) -> Int {
    let value = (x > y) ? x/y : y/x
    return (value > 2) ? value : value+1
}

protocol GraphTouchEventProtocol: AnyObject {
    func lineChart(view: FIChartLineView, didSelectPoint currentPoint: CGPoint, withAxisSize size: CGSize,  events: UIEvent?)
}

public class FIChartLineView: UIView {
    
    var chartData: ChartDataModel? = nil {
        didSet {
            self.removeLayer()
            self.setNeedsDisplay()
        }
    }
    var lineType: LineChartType = .curved
    var xPadding: CGFloat = 10.0
    weak var delegate: GraphTouchEventProtocol?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MFColor.mfBgColor
        self.isUserInteractionEnabled = true
        self.setNeedsDisplay()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func coordYFor(dataSets: [Int] ,index: Int) -> CGFloat {
        return bounds.height - bounds.height * CGFloat(dataSets[index]) / CGFloat(Double((dataSets.max() ?? 0 * 2))) + 5
    }
    
    private func valueForYposition(y: CGFloat) -> Int {
        return Int((bounds.height / y) * (CGFloat(Double((chartData?.yValue.data.max() ?? 0) / 2))))
    }
    
    private var ySize: CGFloat  {
        return bounds.height / CGFloat(chartData?.yValue.data.max() ?? 0)
    }
    
    private var xSize: CGFloat {
        return (bounds.width - 5) / CGFloat(chartData?.xValue.data.count ?? 0) * CGFloat((calculatePointsSpace(x: (chartData?.xValue.data.count ?? 0), y: (chartData?.yValue.data.count ?? 0))))
    }
    
    private func coorXFor(index: Int) -> CGFloat {
        return bounds.width - bounds.width * CGFloat(chartData?.xValue.data[index] ?? 0) / CGFloat((chartData?.xValue.data.max() ?? 0 * 2))
    }
    
    // remove old layers
    func removeLayer() {
        guard let sublayers = self.layer.sublayers else { return }
        for layer in sublayers {
            layer.removeFromSuperlayer()
        }
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let chart_data = self.chartData {
            if let infoData = self.chartData?.infoValue {
                let infoPath = self.createCurvedPath(yValue: infoData)
                self.animatePath(path: infoPath, pathColor: infoData.colors, duration: 1.0, chartData: infoData)
            }
            
            let path = self.createCurvedPath(yValue: chart_data.yValue)
            self.animatePath(path: path, pathColor: chart_data.yValue.colors, duration: 1.0, chartData: chart_data.yValue)
        }
    }
    
     func maxY(dataSets: [Int]) -> Int {
        return dataSets.min() ?? 0
    }
    
    
    private func createCurvedPath(yValue: GraphSet) -> UIBezierPath {
        let path = UIBezierPath()
        var point1 = CGPoint(x: xPadding, y: coordYFor(dataSets: yValue.data, index: 0))
        path.move(to: point1)
        
        // Indicator
        drawCirclePointIndicator(point: point1, color: yValue.colors, radius: 5)
        
        // Data only have 2 points
        if (yValue.data.count == 2) {
            path.addLine(to: CGPoint(x: self.xSize + xPadding , y: coordYFor(dataSets: yValue.data, index: 1)))
            return path
        }
        
        var oldControlP: CGPoint?
        for i in 1..<yValue.data.count {

            switch self.lineType {
            case .curved:
                let point2 = CGPoint(x: (self.xSize * CGFloat(i)) + xPadding, y: coordYFor(dataSets: yValue.data, index: i))
                drawCirclePointIndicator(point: point2, color: yValue.colors, radius: 3)
                
                var point3: CGPoint?
                if i < yValue.data.count - 1 {
                    point3 = CGPoint(x: (self.xSize * CGFloat(i + 1)) + xPadding, y: coordYFor(dataSets: yValue.data, index: i + 1))
                }
                
                if i == yValue.data.count  {
                    point3 = CGPoint(x: (self.xSize * CGFloat(i)), y: coordYFor(dataSets: yValue.data, index: i))
                }
                
                let newControlP = controlPointForTwoPoints(p1: point1, p2: point2, next: point3)
                
                path.addCurve(to: point2, controlPoint1: oldControlP ?? point1, controlPoint2: newControlP ?? point2)
                
                point1 = point2
                oldControlP = centerCurveFor(point: newControlP, center: point2)
            case .line:
                let pLine = CGPoint(x: xSize * CGFloat(i), y: coordYFor(dataSets: yValue.data, index: i))
                path.addLine(to: pLine)
            }
        }
        return path
    }

    
    private func centerCurveFor(point: CGPoint?, center: CGPoint?) -> CGPoint? {
        guard let p1 = point, let center = center else {
            return nil
        }
        let newX = 2 * center.x - p1.x
        let diffY = abs(p1.y - center.y)
        let newY = center.y + diffY * (p1.y < center.y ? 1 : -1)
        
        return CGPoint(x: newX, y: newY)
    }
    
    /// halfway of two points
    func midValueForTwoPoints(p1: CGPoint, p2: CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x + p2.x) / 2, y: (p1.y + p2.y) / 2);
    }
    
    /// Find controlPoint2 for addCurve
    /// - Parameters:
    ///   - p1: first point of curve
    ///   - p2: second point of curve whose control point we are looking for
    ///   - next: predicted next point which will use antipodal control point for finded
    func controlPointForTwoPoints(p1: CGPoint, p2: CGPoint, next p3: CGPoint?) -> CGPoint? {
        guard let p3 = p3 else {
            return nil
        }
        
        let leftMidPoint  = midValueForTwoPoints(p1: p1, p2: p2)
        let rightMidPoint = midValueForTwoPoints(p1: p2, p2: p3)
        
        var controlPoint = midValueForTwoPoints(p1: leftMidPoint, p2: centerCurveFor(point: rightMidPoint, center: p2)!)
        
        if p1.y.between(a: p2.y, b: controlPoint.y) {
            controlPoint.y = p1.y
        } else if p2.y.between(a: p1.y, b: controlPoint.y) {
            controlPoint.y = p2.y
        }
        
        
        let imaginContol = centerCurveFor(point: controlPoint, center: p2)!
        if p2.y.between(a: p3.y, b: imaginContol.y) {
            controlPoint.y = p2.y
        }
        if p3.y.between(a: p2.y, b: imaginContol.y) {
            let diffY = abs(p2.y - p3.y)
            controlPoint.y = p2.y + diffY * (p3.y < p2.y ? 1 : -1)
        }
        
        // make lines easier
        controlPoint.x += (p2.x - p1.x) * 0.1
        return controlPoint
    }
    
    
    private func animatePath(path: UIBezierPath, pathColor: UIColor, duration: Double, chartData: GraphSet) {
        let pathLayer: CAShapeLayer = CAShapeLayer()
        pathLayer.frame = self.bounds
        pathLayer.path = path.cgPath
        
        pathLayer.strokeColor = pathColor.cgColor
        pathLayer.fillColor = nil
        pathLayer.lineWidth = 1.0
        pathLayer.lineJoin = CAShapeLayerLineJoin.bevel
        //pathLayer.lineDashPattern = [4, 4]
        self.layer.addSublayer(pathLayer)
       
        if chartData.graphDataPoint != .infoValue {
            self.drawGradient(path: path, color: pathColor, chartData: chartData)
        }

        let pathAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = duration
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = 1.0
        //Animation will happen right away
        pathLayer.add(pathAnimation, forKey: "strokeEnd")

    }
    
    
    func drawGradient(path: UIBezierPath, color: UIColor, chartData: GraphSet) {
        // Line add gradient colors
        if let context = UIGraphicsGetCurrentContext() {
            // add clipping path. this draws an imaginary line (to create bounds) from the
            //ends of the UIBezierPath line down to the bottom of the screen
            let clippingPath = path.copy() as! UIBezierPath
            clippingPath.addLine(to: CGPoint(x: xSize * CGFloat(chartData.data.count), y: self.bounds.height))
            clippingPath.addLine(to: CGPoint(x: 10, y: bounds.height))
            clippingPath.close()
            
            clippingPath.addClip()
            
            // create and add the gradient
            let colors = [color.cgColor, UIColor.white.withAlphaComponent(0.4).cgColor]
            
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let colorLocations:[CGFloat] = [0.0, 1.0]
            
            if let gradient = CGGradient(
                colorsSpace: colorSpace,
                colors: colors as CFArray,
                locations: colorLocations
            )  {
                let startPoint = CGPoint(x: 1, y: 1.0)
                let endPoint = CGPoint(x: 1.0, y: bounds.maxY)
                
                context.drawLinearGradient(
                    gradient,
                    start: startPoint,
                    end: endPoint,
                    options: []
                )
            }
        }
    }
    
    func drawCirclePointIndicator(point: CGPoint, color: UIColor, radius: CGFloat) {
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: point.x - radius, y: point.y - radius, width: radius * 2, height: radius * 2))
        color.setFill()
        ovalPath.fill()
    }
}


extension FIChartLineView {
   
    fileprivate func handleTouchEvents(_ currentPoint: CGPoint, event: UIEvent?) {
        delegate?.lineChart(view: self, didSelectPoint: currentPoint, withAxisSize: CGSize(width: xSize, height: ySize), events: event)
    }


    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            handleTouchEvents(currentPoint, event: event)
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            handleTouchEvents(currentPoint, event: event)
        }
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            handleTouchEvents(currentPoint, event: event)

        }
    }
}


extension CGFloat {
    func between(a: CGFloat, b: CGFloat) -> Bool {
        return self >= Swift.min(a, b) && self <= Swift.max(a, b)
    }
}








