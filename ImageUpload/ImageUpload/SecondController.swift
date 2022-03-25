//
//  SecondController.swift
//  ImageUpload
//
//  Created by Vijay on 30/10/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import UIKit


extension UIView {
    
    func rotateAnimation(duration: CFTimeInterval = 2.0, rotateValue: CGFloat) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * rotateValue)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = .infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
}

class Cell: UITableViewCell {
    
    @IBOutlet weak var imag: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // imag.rotateAnimation(rotateValue: 20)
    }
    
    
}

class SecondController: UIViewController ,UITableViewDelegate , UITableViewDataSource {
   
    var shownIndexes : [IndexPath] = []
    let CELL_HEIGHT : CGFloat = 40
    var baseControler: UIViewController? = nil
    
    var arrays: [String] = ["vijay","kumar","mss","vijay1","kumar1","ms1s", "ndd3","kumar2","mss2","afef"]
    var dublicateArray: [String] = [String]()
    var isFirsttime = false
    
    weak var timer: Timer?

    
    @IBOutlet weak var table: UITableView!
    var rotateValue: CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        table.estimatedRowHeight = 85.0
        table.rowHeight = UITableView.automaticDimension
        self.view.backgroundColor = .red
        loadTimer()
        // Do any additional setup after loading the view.
    }
    
    func loadTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
           
            guard let self = self else { return }
            self.shownIndexes = [IndexPath]()
            self.dublicateArray = [String]()
            
            let randomArray = (0...9).shuffled()
            for i in randomArray {
                let indexPath = IndexPath(item: Int(i), section: 0)
                self.shownIndexes.append(indexPath)
                self.dublicateArray.append(self.arrays[indexPath.row])
            }
            self.arrays = self.dublicateArray
            //table.reloadData()
            self.table.reloadRows(at: self.shownIndexes, with: .none)
            
        }
    }
    
    static func loadController() -> SecondController? {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "SecondController") as? SecondController {
             return controller
        }
        return nil
    }
    
    var tableContentSize: CGSize {
        DispatchQueue.main.async {
            self.table.reloadData()
        }
        self.table.layoutIfNeeded()
        return table.contentSize
    }
    
    static func showBuySellDrawer() -> UIViewController? {
        if let buySellController = loadController() {
            let viewController = UIViewController()
            
            buySellController.dublicateArray = buySellController.arrays
            buySellController.baseControler = viewController

            viewController.addChild(buySellController)
            viewController.view.addSubview(buySellController.view)
            buySellController.didMove(toParent: viewController)
            buySellController.table.reloadData()

            buySellController.view.translatesAutoresizingMaskIntoConstraints = false

            buySellController.view.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: viewController.view.topAnchor, multiplier: 1.0).isActive = true
           // buySellController.view.topAnchor.constraint(equalTo: viewController.view.topAnchor).isActive = true

            buySellController.view.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor).isActive = true
            buySellController.view.leftAnchor.constraint(equalTo: viewController.view.leftAnchor).isActive = true
            buySellController.view.rightAnchor.constraint(equalTo: viewController.view.rightAnchor).isActive = true

            buySellController.view.heightAnchor.constraint(equalToConstant: buySellController.table.contentSize.height).isActive = true

            // buySellController.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: controller.view.bounds.width ?? 100 , height: controller?.view.bounds.height ?? 100)
//
//            // buySellController.openClose()
            return viewController
        }
        return nil
    }
    
    
    // child view controller open close functionality
    func openClose() {
        if self.view.frame.origin.y == UIScreen.main.bounds.size.height {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.frame.origin.y = UIScreen.main.bounds.size.height-self.table.contentSize.height
            }) { (stop) in
            }
            
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.frame.origin.y = UIScreen.main.bounds.size.height
            }) { (stop) in
            }
        }
    }
    
    
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        shownIndexes = [IndexPath]()
        dublicateArray = [String]()

            let randomArray = (0...9).shuffled()
            for i in randomArray {
                let indexPath = IndexPath(item: Int(i), section: 0)
                shownIndexes.append(indexPath)
                dublicateArray.append(arrays[indexPath.row])
            }
            arrays = dublicateArray
        //table.reloadData()
        table.reloadRows(at: shownIndexes, with: .fade)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrays.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.textLabel?.text = arrays[indexPath.row]
      //  cell.imag.startAnimating()
       // shownIndexes.append(indexPath)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.table.reloadInputViews()
    }
    
    
    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        rotateValue = scrollView.adjustedContentInset.bottom
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
    }
    
    
}


extension Array {
    func rand() -> Element? {
        if self.isEmpty { return nil }
        let randomInt = Int(arc4random_uniform(UInt32(self.count)))
        return self[randomInt]
    }
}



extension SecondController: StreamDelegate {
    
    
    
}
