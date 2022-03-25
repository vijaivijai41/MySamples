//
//  CustomTabBarController.swift
//  SimpleCustomTabBar
//
//  Created by Vijay on 19/08/20.
//

import UIKit

struct Device {
    static let safeAreaBottom = UIApplication.shared.windows.last?.safeAreaInsets.bottom ?? 0.0
    static let safeAreaTop = UIApplication.shared.windows.last?.safeAreaInsets.top ?? 0.0
}


class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor(named: "TabbarColor")

        customCenterButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    // customize button added in tabbar
    lazy var customCenterButton: UIButton =  {
        let size = tabBar.subviews[0].frame.size.height
        print(size)
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: size, height: size))
        
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - (menuButtonFrame.size.height*1.5 + Device.safeAreaBottom)
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        
        menuButton.backgroundColor = UIColor(named: "BgColor")
        menuButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        view.addSubview(menuButton)
        
        menuButton.setImage(UIImage(systemName: "plus"), for: .normal)
        menuButton.tintColor = UIColor(named: "TabbarColor")
        view.layoutIfNeeded()
        return menuButton
    }()
    
    @objc func menuButtonAction(sender: UIButton) {
        _ = SwipeButtonlist.showMenuItems(superView: self, sender: sender, items: [.addInvestor,.equity,.more,.mutualFund], didSelectionHandler: { (item) in
            print(item)
        })
    }
}


