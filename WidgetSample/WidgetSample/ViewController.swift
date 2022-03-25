//
//  ViewController.swift
//  WidgetSample
//
//  Created by Vijay on 06/08/20.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    
    let arr = Array(1...200)

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let num = arr[indexPath.row]
        cell.textLabel?.text = "\(num)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let num = arr[indexPath.row]
        
        if let userDefaults = UserDefaults(suiteName: "group.com.putterfitter.NotesWidget"){
            userDefaults.set(String(num), forKey: "SelectedNumber")
        }
        
    }
    
}

