//
//  MasterViewController.swift
//  SplitControllerSample
//
//  Created by FIuser on 01/07/19.
//  Copyright © 2019 FundsIndia. All rights reserved.
//

import UIKit

class MasterViewController: BaseController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    let pageTitle = ["page1","page2"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    @objc func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
    }
   
   
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /// Slide over updated for views
        if UIScreen.main.traitCollection.horizontalSizeClass == .regular && UIScreen.main.traitCollection.verticalSizeClass == .regular  {
            if isSplited {
                self.showHideSplitView()
            }
        } else {
            self.showHideSplitView()
        }
        
        // Segue conection for detail pages
        if segue.identifier == "detail" {
            if let indexPath = table.indexPathForSelectedRow {
                _ = pageTitle[indexPath.row]
                _ = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            }
        } else {
            if segue.identifier == "detail2" {
                if let indexPath = table.indexPathForSelectedRow {
                   _ = pageTitle[indexPath.row]
                   _ = (segue.destination as! UINavigationController).topViewController as! Detail2ViewController
                }
            }
        }
    }

    // MARK: - Table View

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pageTitle.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let object = pageTitle[indexPath.row]
        cell.textLabel?.text = object
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var identifier = ""
        if indexPath.row == 0 {
            identifier = "detail"
        } else {
            identifier = "detail2"
        }
        self.performSegue(withIdentifier: identifier, sender: self)
       
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

    }


}

