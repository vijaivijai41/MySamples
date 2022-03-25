//
//  profileCoordinator.swift
//  simplCoordinaterSample
//
//  Created by Vijay on 08/11/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import UIKit


 class profileCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    
    unowned let navigationControler: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationControler = navigationController
    }
    
    func start() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyBoard.instantiateViewController(withIdentifier: "ProfileController") as? ProfileController {
            self.navigationControler.pushViewController(controller, animated: true)
        }
    }
    
}


public protocol profileCoordinatorDelegate: class {
    
    func showChangePassword()
}
