//
//  AppCoordinator.swift
//  PaytapConfigure
//
//  Created by Vijay on 06/06/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    var childCoordinator: [Coordinator] = []
    let repository: Repository
    
    init(navigationController: UINavigationController, repository: Repository) {
        self.repository = repository
        self.navigationController = navigationController
    }
   
    func start() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
        let homeController = storyboard.instantiateViewController(identifier: "CheckoutController") as! CheckoutController
        let viewModel = CheckoutViewModel(viewDelegate: homeController, coordinatorDelaget: self)
        homeController.viewModel = viewModel
        self.navigationController.viewControllers = [homeController]

    }
    
    
    // add coordinator append
    func addCoordinator(coordinator: Coordinator) {
        if !childCoordinator.contains(where: { $0 === coordinator}) {
            childCoordinator.append(coordinator)
        }
    }
    
    // remove coordinator releade coordinator
    func removeCoordinator(coordinator: Coordinator) {
        childCoordinator = childCoordinator.filter { $0 !== coordinator }
    }
    
    deinit {
        print("deinitialize App coodinator")
    }
}



extension AppCoordinator: CheckoutCoordinatorDelegate {
    
    func checkoutViewModel(viewModel: CheckoutViewModel, didProceedPaymentScene info: CheckoutInfo) {
        guard let topController = self.navigationController.viewControllers.first as? CheckoutController else { return }
        let checkoutCoordinator = CheckoutCoordinator(parentController: topController, repository: repository, checkoutInfo: info, viewModel: viewModel)
        self.addCoordinator(coordinator: checkoutCoordinator)
        checkoutCoordinator.start()
    }
    
    func dismissPayment(with viewModel: CheckoutViewModel) {
        // dismiss notify
        print("paymemt dismiss")
    }
    
    func checkoutViewModel(viewModel: CheckoutViewModel, didProceedSuccessScene successInfo: SuccessInfo) {
        // paymey status notify
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSucessController") as! PaymentSucessController
        self.navigationController.pushViewController(vc, animated: true)
    }
}
