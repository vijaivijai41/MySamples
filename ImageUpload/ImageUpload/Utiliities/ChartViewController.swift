//
//  ChartViewController.swift
//  ImageUpload
//
//  Created by Vijay on 26/11/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit


class YaxisTableSource: UITableView, UITableViewDelegate,UITableViewDataSource {
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.delegate = self
        self.dataSource = self
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(numberOfRows(inSection: indexPath.section) - indexPath.row)"
        return cell
    }
    
}



class XAxisCell: UICollectionViewCell {
    
    @IBOutlet weak var txtLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


class XaxisCollection: UICollectionView ,UICollectionViewDelegate,UICollectionViewDataSource {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.dataSource = self
        self.delegate = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XAxisCell", for: indexPath) as! XAxisCell
        cell.txtLabel.text = "\(indexPath.item)"
        return cell
        
    }
    
}


class ChartViewController: UIViewController {

    @IBOutlet weak var yTable: YaxisTableSource!
    @IBOutlet weak var xCollection: XaxisCollection!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var xData = [0,70,45,70,84,90,90,300,400]
        var yData = [0,5,10,60,34,600,250,260,400]

        self.yTable.reloadData()
        self.xCollection.reloadData()
        
        let pi = CGFloat(Float.pi)
        let start:CGFloat = 0.0
        let end :CGFloat = pi

        // circlecurve
        let path: UIBezierPath = UIBezierPath();
       
       let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x:40, y:self.yTable.frame.size.height - 40))
        let tableheight = self.yTable.frame.size.height

        for (index ,data) in xData.enumerated() {
            aPath.addLine(to: CGPoint(x:data, y: Int(tableheight) - yData[index]))
        }
        

       //Keep using the method addLineToPoint until you get to the one where about to close the path

       aPath.close()

       //If you want to stroke it with a red color
       UIColor.red.set()
       aPath.stroke()
       //If you want to fill it as well
       aPath.fill()
//        path.addArc(
//            withCenter: CGPoint(x:self.view.frame.width/4, y:self.view.frame.height/4),
//            radius: 10,
//            startAngle: start,
//            endAngle: end,
//            clockwise: true
//        )
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.orange.cgColor
        layer.path = aPath.cgPath
        self.yTable.layer.addSublayer(layer)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
