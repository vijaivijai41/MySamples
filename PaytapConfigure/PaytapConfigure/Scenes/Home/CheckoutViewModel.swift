//
//  CheckoutViewModel.swift
//  PaytapConfigure
//
//  Created by Vijay on 10/06/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import Foundation


protocol CheckoutViewModelDelegte : class {
    
    func checkoutViewModel(viewModel: CheckoutViewModel, didProccedPayment info: CheckoutInfo)
    
    func checkoutViewModel(viewMoel: CheckoutViewModel, didFailure error: String)
    
}

protocol CheckoutCoordinatorDelegate: class {
    func checkoutViewModel(viewModel: CheckoutViewModel, didProceedPaymentScene info: CheckoutInfo)
    
    func dismissPayment(with viewModel: CheckoutViewModel)
    
    func checkoutViewModel(viewModel: CheckoutViewModel, didProceedSuccessScene successInfo: SuccessInfo)
    
}

class CheckoutViewModel {
    
    weak var viewDelegate:CheckoutViewModelDelegte?
    weak var coordinatorDelaget: CheckoutCoordinatorDelegate?
    
    init(viewDelegate: CheckoutViewModelDelegte, coordinatorDelaget: CheckoutCoordinatorDelegate) {
        
        self.coordinatorDelaget = coordinatorDelaget
        self.viewDelegate = viewDelegate
    }
    
    // proceed button action
    func proccedButonDidTap(info: CheckoutInfo) {
        self.coordinatorDelaget?.checkoutViewModel(viewModel: self, didProceedPaymentScene: info)
    }
    
    func dismissHandler() {
        self.coordinatorDelaget?.dismissPayment(with: self)
    }
    
    
    func paymentSuccess(info: SuccessInfo) {
        self.coordinatorDelaget?.checkoutViewModel(viewModel: self, didProceedSuccessScene: info)
    }
    
    
}
