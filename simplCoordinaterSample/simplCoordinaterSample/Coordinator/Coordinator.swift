//
//  Coordinator.swift
//  simplCoordinaterSample
//
//  Created by Vijay on 08/11/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import UIKit

public protocol Coordinator: class {
    var childCoordinator: [Coordinator] { get set }
    
    init(navigationController: UINavigationController)
    
    func start()
   
}


