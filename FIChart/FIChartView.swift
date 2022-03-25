//
//  ChartView.swift
//  FICommon
//
//  Created by Vijay on 25/06/21.
//  Copyright © 2020 FundsIndia. All rights reserved.
//

import Foundation
import UIKit

public enum GraphDataPoint {
    case xValue
    case yValue
    case infoValue
}

public struct GraphSet {
    let colors: UIColor
    let data: [Int]
    let graphDataPoint: GraphDataPoint
    
    public init( colors: UIColor, data: [Int], graphDataPoint: GraphDataPoint) {
        self.colors = colors
        self.data = data
        self.graphDataPoint = graphDataPoint
    }

}

public struct ChartDataModel {
    let xValue: GraphSet
    let yValue: GraphSet
    let infoValue: GraphSet?
    
    public init(xValue: GraphSet, yValue: GraphSet, infoValue: GraphSet?) {
        self.xValue = xValue
        self.yValue = yValue
        self.infoValue = infoValue
    }
}


public enum LineChartType {
    case curved
    case line
}

@IBDesignable
public class FIChartView: UIView {
    
    public var lineType: LineChartType = .curved

    @IBInspectable var pointCurveColor: UIColor = .black
    @IBInspectable var lineColor: UIColor = .red
    private var arrayElements: [Int] = []
    private var chartData: ChartDataModel!
    public var xXaxisLimit: Int = 4
    
    // graph date updated
    public func showGraphWithData(chartData: ChartDataModel) {
        self.chartData = chartData
        self.caluculateXaxisValue(value: chartData.xValue.data)

        let bundleX = Bundle.init(for: XAxisCell.self)
        let bundleY = Bundle.init(for: YLineTableCell.self)

        self.xAxisView.register(UINib(nibName: "XAxisCell", bundle: bundleX), forCellWithReuseIdentifier: "XAxisCell")
        self.yAxisView.register(UINib(nibName: "YLineTableCell", bundle: bundleY), forCellReuseIdentifier: "YLineTableCell")

        self.chartView.delegate = self
        self.chartView.chartData = self.chartData
        self.xAxisView.delegate = self
        self.xAxisView.dataSource = self
        self.backgroundColor = MFColor.mfBgColor
        
        self.xAxisView.backgroundColor = MFColor.mfBgColor
        self.yAxisView.backgroundColor = MFColor.mfBgColor
        self.yAxisView.delegate = self
        self.yAxisView.dataSource = self
        
        self.yAxisView.reloadData()
        self.xAxisView.reloadData()
    }
    
    // Xaxis value
    private func caluculateXaxisValue(value: [Int]) {
        arrayElements.removeAll()
        for i in 0..<xXaxisLimit {
            var index = value.count / xXaxisLimit
            index *= i
            arrayElements.append(value[index])
        }
    }
    
    private var xSize: CGFloat {
        self.frame.size.width / CGFloat(arrayElements.count)
    }
    
    private lazy var chartView: FIChartLineView = {
        let view = FIChartLineView()
        view.translatesAutoresizingMaskIntoConstraints = false
       
        view.lineType = self.lineType

        self.baseView.addSubview(view)
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    private lazy var xAxisView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: CGRect.zero,collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.setCollectionViewLayout(layout, animated: true)
        collection.backgroundColor = .red
        self.baseView.addSubview(collection)
        return collection
    }()
    
    private lazy var yAxisView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .singleLine
        table.separatorColor = MFColor.mfLightLabel
        table.translatesAutoresizingMaskIntoConstraints = false
        self.baseView.addSubview(table)
        return table
    }()
    
    
    private lazy var baseScroll: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(scrollView)
        return scrollView
    }()
    
    private lazy var baseView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.baseScroll.addSubview(view)
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        // Base scroll constrains
        NSLayoutConstraint.activate([
            self.baseScroll.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.baseScroll.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.baseScroll.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.baseScroll.topAnchor.constraint(equalTo: self.topAnchor)])
      
        //BaseView constrains
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.baseScroll.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.baseScroll.trailingAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.baseScroll.bottomAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.baseScroll.topAnchor),
            self.baseView.centerYAnchor.constraint(equalTo: self.baseScroll.centerYAnchor),
            self.baseView.centerXAnchor.constraint(equalTo: self.baseScroll.centerXAnchor)])
        
        //ChartViewConstrains
        NSLayoutConstraint.activate([
            self.chartView.topAnchor.constraint(equalTo: self.baseView.topAnchor),
            self.chartView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor,constant: 0),
            self.chartView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor,constant: 0),
            self.chartView.heightAnchor.constraint(equalTo: self.baseView.heightAnchor, multiplier: 0.9)])
        //xAxis view constrains
        NSLayoutConstraint.activate([
            self.xAxisView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.xAxisView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.xAxisView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor),
            self.xAxisView.heightAnchor.constraint(equalTo: self.baseView.heightAnchor, multiplier: 0.1),
            self.xAxisView.topAnchor.constraint(equalTo: self.chartView.bottomAnchor)])
       
        // YAxis view constrains
        NSLayoutConstraint.activate([
            self.yAxisView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.yAxisView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.yAxisView.bottomAnchor.constraint(equalTo: self.chartView.bottomAnchor),
            self.yAxisView.topAnchor.constraint(equalTo: self.chartView.topAnchor)])
    }
}



// UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension FIChartView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayElements.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XAxisCell", for: indexPath) as! XAxisCell
        cell.nameLabel.text = "\(self.arrayElements[indexPath.item])"
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: xSize , height: collectionView.frame.size.height)
    }
}


extension FIChartView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YLineTableCell", for: indexPath) as! YLineTableCell
        return cell
    }
}


extension FIChartView: GraphTouchEventProtocol {
    func lineChart(view: FIChartLineView, didSelectPoint currentPoint: CGPoint, withAxisSize size: CGSize, events: UIEvent?) {
        print(self.chartData.yValue)
        let xPoint =  returnXvalue(x: currentPoint.x, xSize: size.width)
        print("xAxis:\(xPoint)")
        let value = returnYvalue(y: currentPoint.y, ySize: size.height)
        print("yAxis:\(value)")
        addToolTipView(currentPoint: currentPoint, selectedPointWith: xPoint, y: value)
    }
    
    // Return
    private func returnXvalue(x: CGFloat, xSize: CGFloat) -> String {
        let valueCount = Int(floor(x / xSize)) * calculatePointsSpace(x: chartData.xValue.data.count, y: chartData.yValue.data.count)
        let index = (valueCount > chartData.xValue.data.count - 1) ? chartData.xValue.data.count - 1 : (valueCount > 0) ? valueCount : 0
        return String(chartData.xValue.data[index])
    }
    
    private func returnYvalue(y: CGFloat, ySize: CGFloat) -> String {
        return String(ceil((self.chartView.bounds.size.height - y) / ySize))
    }
}

