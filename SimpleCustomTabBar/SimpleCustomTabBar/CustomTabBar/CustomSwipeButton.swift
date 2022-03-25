//
//  CustomSwipeButton.swift
//  SimpleCustomTabBar
//
//  Created by Vijay on 19/08/20.
//

import Foundation
import UIKit

// Menu item
public enum MenuButton: String, CaseIterable {
    case mutualFund = "Mutual Fund"
    case equity = "Stoct market"
    case addInvestor = "New Investor"
    case more = "More"
    
    var image: UIImage? {
        switch self {
        case .more:
            return UIImage(named: "facebook")
        case .addInvestor:
            return UIImage(named: "instagram")
        case .equity:
            return UIImage(named: "youtube")
        case .mutualFund:
            return UIImage(named: "twitter")
        }
    }
}

// Hanlder action
typealias MenuSelectionHandler = (_ selection: MenuButton) -> ()



class SwipeButtonlist: UIView {
    var senderView: UIView?
    var items: [MenuButton] = []
    var itemsHeight: CGFloat = 0.0
    var baseView: UIView?
    
    var selectionHandler: MenuSelectionHandler?
    
    static func initialize(frame: CGRect) -> SwipeButtonlist? {
        return SwipeButtonlist(frame: frame)
    }
    
    static func showMenuItems(superView: UIViewController, sender: UIButton, items: [MenuButton], didSelectionHandler: MenuSelectionHandler?) -> SwipeButtonlist? {
        if let view  = initialize(frame: CGRect(x: sender.frame.origin.x + 5 ,
                                                y: sender.frame.origin.y ,
                                                width: sender.frame.size.width,
                                                height: 100)) {
            view.items = items
            view.selectionHandler = didSelectionHandler
            view.itemsHeight = CGFloat(items.count * 40)
            view.senderView = sender
            view.baseView = superView.view
            view.backgroundColor = .clear
            view.tag = 1030230
            view.animShowHide()
            view.addSubview(view.ButtonList)
            view.ButtonList.reloadData()
            
            return view
        }
        
        return nil
    }
    
    // Button list view implement
    lazy var ButtonList: UITableView = {
        let tableView = UITableView(frame: CGRect(x:0,y: 0,width: 40, height: self.itemsHeight))
        tableView.register(UINib(nibName: "ButtonViewCell", bundle: nil), forCellReuseIdentifier: "ButtonViewCell")
        tableView.delegate = self
        tableView.backgroundColor = .red
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        return tableView
    }()
    
    // animat show and hide
    public func animShowHide() {
        if let baseview = self.baseView {
            let buttonView = baseview.viewWithTag(1030230)
            if buttonView != nil {
                guard let sender = senderView else  { return }
                UIView.animate(withDuration: 0.5, delay: 0.0, options: []) {
                    self.frame = CGRect(x: sender.frame.origin.x + 5 ,
                                        y: sender.frame.origin.y,
                                        width: sender.frame.size.width,
                                        height: self.itemsHeight)
                   
                    
                } completion: { (completed) in
                    buttonView?.removeFromSuperview()
                }
                
            } else {
                guard let sender = senderView else  { return }
                UIView.animate(withDuration: 0.25, delay: 0.0, options: []) {
                    baseview.addSubview(self)
                    self.bringSubviewToFront(baseview)
                    self.frame = CGRect(x:  sender.frame.origin.x + 5,
                                        y: sender.frame.origin.y - self.itemsHeight,
                                        width: sender.frame.size.width,
                                        height: self.itemsHeight)
                } completion: { (completed) in
                    
                }
            }
        }
    }
    
}


// Tableview delegate and datastore
extension SwipeButtonlist: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonViewCell", for: indexPath) as! ButtonViewCell
        cell.bgImageView.image = items[indexPath.row].image
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        selectionHandler?(item)
        self.removeFromSuperview()
    }    
    
}

