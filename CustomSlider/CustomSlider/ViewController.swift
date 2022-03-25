//
//  ViewController.swift
//  CustomSlider
//
//  Created by Vijay on 31/12/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sliderView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let track = TrackView()
        track.frame = CGRect(x: 0, y: 10, width: 100, height: 2)
        track.setNeedsDisplay()
        self.sliderView.layer.addSublayer(track)
        
    }
}


class ScaleLayer: CALayer {
    
}



class TrackView: CALayer {
 
    override func draw(in ctx: CGContext) {
        ctx.setFillColor(UIColor.red.cgColor)
        ctx.setShadow(offset: CGSize(width: 1, height: 1), blur: 0.5)
        
        let cornerRadius: CGFloat = 5
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        ctx.addPath(path.cgPath)
        
        // Fill the track
        ctx.setFillColor(UIColor.red.cgColor)
        ctx.addPath(path.cgPath)
        ctx.fillPath()
       
        let rect = CGRect(x: 0, y: 0.0, width: bounds.width, height: 2.0)
        ctx.fill(rect)
    }
}
