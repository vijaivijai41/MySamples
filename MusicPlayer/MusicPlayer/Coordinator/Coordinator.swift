//
//  Coordinator.swift
//  MovieList
//
//  Created by Vijay on 07/07/20.
//  Copyright © 2020 Vijay. All rights reserved.
//



import Foundation
import UIKit

public protocol Coordinator: class {
    
    var childCoordinator: [Coordinator]  { get set }
    func start()
}
