//
//  MainCoordinator.swift
//  simplCoordinaterSample
//
//  Created by Vijay on 08/11/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    
    unowned let navigationController:UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            controller.delegate = self
            self.navigationController.viewControllers = [controller]
        }
    }
    
    
}



extension MainCoordinator: MainCoordinatorDelegate {
    func moveSecondController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController {
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
    
    func showProfile() {
        let coordinator = profileCoordinator(navigationController: self.navigationController)
        childCoordinator.append(coordinator)
        coordinator.start()
    }
}




public protocol MainCoordinatorDelegate: class {
    func moveSecondController()
    func showProfile()
}

