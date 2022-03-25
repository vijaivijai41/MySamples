//
//  ViewController.swift
//  SearchSample
//
//  Created by Vijay on 18/11/20.
//

import UIKit
import MobileCoreServices
import MapKit

class ViewController: UIViewController, UIDocumentPickerDelegate {
    
    @IBOutlet weak var topHeader: UIView!
    @IBOutlet weak var tableVuew: UITableView!
    private var lastContentOffset: CGFloat = 0
    let refreshControl = CustomRefreshControl()

    @IBOutlet weak var headerImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var images: [UIImage] = []
        for i in 1...10 {
            images.append(UIImage(named: "\(i).png")!)
        }

        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableVuew.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    @objc func refresh(_ sender: CustomRefreshControl) {
       // Code to refresh table view
        print("start refreshing")
        sender.endRefreshing()
    }
    @IBOutlet weak var baseScroll: UIScrollView!
    
    @IBAction func openFoldderActoin(_ sender: Any) {
        let options = [String(kUTTypePDF)]
        
        let documentPickerViewController = UIDocumentPickerViewController(documentTypes: options, in: .import)
        documentPickerViewController.delegate = self
        present(documentPickerViewController, animated: true, completion: nil)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Cancelled")
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("didPickDocuments at \(urls)")
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "HI"
        return cell
    }
}


//extension ViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let yPos: CGFloat = scrollView.contentOffset.y
//        if (self.lastContentOffset > scrollView.contentOffset.y) {
//            // move up
//            print("down")
//            
//            var mapViewRect: CGRect = self.topHeader.frame
//            mapViewRect.origin.y = 0
//            UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
//                self.topHeader.frame = mapViewRect
//                    self.view.layoutIfNeeded()
//                }) { (_) in
//                    // Follow up animations...
//                }
//            
//        }
//        else if (self.lastContentOffset < scrollView.contentOffset.y) {
//            // move down
//            print("up")
//            if (yPos > 0) {
//                var mapViewRect: CGRect = self.topHeader.frame
//                mapViewRect.origin.y = -scrollView.contentOffset.y
//                UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
//                    self.topHeader.frame = mapViewRect
//                        self.view.layoutIfNeeded()
//                    }) { (_) in
//                        // Follow up animations...
//                    }
//            }
//        }
//        
//        // update the new position acquired
//        self.lastContentOffset = scrollView.contentOffset.y
//                
//    }
//    
//}
//    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    //        if scrollView.contentOffset.y >= 0 {
//    //            if tableVuew.contentOffset.y >= topHeader.frame.size.height  {
//    //                self.topHeader.frame.origin.y = tableVuew.contentOffset.y
//    //                self.topHeader.frame.size.height -= tableVuew.contentOffset.y
//    //            } else {
//    //
//    //            }
//    //        } else {
//    //            self.baseScroll.contentOffset = CGPoint(x: 0, y: 0)
//    //        }
//    //
//    //        if (self.lastContentOffset > scrollView.contentOffset.y) {
//    //               // move up
//    //            print("down")
//    //           }
//    //           else if (self.lastContentOffset < scrollView.contentOffset.y) {
//    //              // move down
//    //            print("up")
//    //           }
//    //
//    //           // update the new position acquired
//    //           self.lastContentOffset = scrollView.contentOffset.y
//    //    }
