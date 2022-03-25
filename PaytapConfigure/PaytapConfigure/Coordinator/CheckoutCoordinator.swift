//
//  CheckoutCoordinator.swift
//  PaytapConfigure
//
//  Created by Vijay on 10/06/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import Foundation
import UIKit

class CheckoutCoordinator:NSObject, Coordinator {
    
    var childCoordinator: [Coordinator] = []
    
    let parentController: CheckoutController
    let repository: Repository
    let viewModel: CheckoutViewModel
    let checkoutInfo: CheckoutInfo
   
    var initialSetupViewController: PTFWInitialSetupViewController!
    var paymentController: PTFWOperationPrepareTransaction!

    
    init(parentController: CheckoutController, repository: Repository, checkoutInfo: CheckoutInfo, viewModel: CheckoutViewModel) {
        self.repository = repository
        self.parentController = parentController
        self.checkoutInfo = checkoutInfo
        self.viewModel = viewModel
    }
    
    
    func start() {

            
            self.paymentController = PTFWOperationPrepareTransaction()
            
            let bundle = Bundle(url: Bundle.main.url(forResource: "Resources", withExtension: "bundle")!)
            self.initialSetupViewController = PTFWInitialSetupViewController.init(
                bundle: bundle,
                andWithViewFrame: self.parentController.view.frame,
                andWithAmount: 5.0,
                andWithCustomerTitle: "PayTabs Sample App",
                andWithCurrencyCode: "USD",
                andWithTaxAmount: 0.0,
                andWithSDKLanguage: "en",
                andWithShippingAddress: "Manama",
                andWithShippingCity: "Manama",
                andWithShippingCountry: "BHR",
                andWithShippingState: "Manama",
                andWithShippingZIPCode: "123456",
                andWithBillingAddress: "Manama",
                andWithBillingCity: "Manama",
                andWithBillingCountry: "BHR",
                andWithBillingState: "Manama",
                andWithBillingZIPCode: "1234543242",
                andWithOrderID: "1234343345",
                andWithPhoneNumber: "004324973331097814",
                andWithCustomerEmail: "rhegazy@paytabs.com",
                andIsTokenization:false,
                andIsPreAuth: false,
                andWithMerchantEmail: "rhegazy@paytabs.com",
                
                andWithMerchantSecretKey: "BIueZNfPLblJnMmPYARDEoP5x1WqseI3XciX0yNLJ8v7URXTrOw6dmbKn8bQnTUk6ch6L5SudnC8fz2HozNBVZlj7w9uq4Pwg7D1",
                andWithAssigneeCode: "SDK",
                andWithThemeColor:UIColor.red,
                andIsThemeColorLight: false)
            
            
            self.initialSetupViewController.didReceiveBackButtonCallback = {
                
            }
            
            self.initialSetupViewController.didStartPreparePaymentPage = {
                // Start Prepare Payment Page
                // Show loading indicator
            }
            self.initialSetupViewController.didFinishPreparePaymentPage = {
                // Finish Prepare Payment Page
                // Stop loading indicator
            }
            
            self.initialSetupViewController.didReceiveFinishTransactionCallback = {(responseCode, result, transactionID, tokenizedCustomerEmail, tokenizedCustomerPassword, token, transactionState) in
                print("Response Code: \(responseCode)")
                print("Response Result: \(result)")
                
                // In Case you are using tokenization
                print("Tokenization Cutomer Email: \(tokenizedCustomerEmail)");
                print("Tokenization Customer Password: \(tokenizedCustomerPassword)");
                print("TOkenization Token: \(token)");
            }

        self.parentController.view.addSubview(initialSetupViewController.view)
        self.parentController.addChild(initialSetupViewController)
            
        initialSetupViewController.didMove(toParent: self.parentController)
//        var amount: Float = 0.0
//        if let _amount = Float(checkoutInfo.amount)  {
//            amount = _amount
//        }
//
//        self.initialSetupViewController = PTFWInitialSetupViewController(
//            bundle: repository.dataStore.resourceBundle,
//            andWithViewFrame: parentController.view.frame,
//            andWithAmount: 5.0,
//            andWithCustomerTitle: "PayTabs Sample App",
//            andWithCurrencyCode: "USD",
//            andWithTaxAmount: 0.0,
//            andWithSDKLanguage: "en",
//            andWithShippingAddress: "Manama",
//            andWithShippingCity: "Manama",
//            andWithShippingCountry: "BHR",
//            andWithShippingState: "Manama",
//            andWithShippingZIPCode: "123456",
//            andWithBillingAddress: "Manama",
//            andWithBillingCity: "Manama",
//            andWithBillingCountry: "BHR",
//            andWithBillingState: "Manama",
//            andWithBillingZIPCode: "1234543242",
//            andWithOrderID: "1234343345",
//            andWithPhoneNumber: "004324973331097814",
//            andWithCustomerEmail: "rhegazy@paytabs.com",
//            andIsTokenization:false,
//            andIsPreAuth: false,
//            andWithMerchantEmail: "rhegazy@paytabs.com",
//
//            andWithMerchantSecretKey: "BIueZNfPLblJnMmPYARDEoP5x1WqseI3XciX0yNLJ8v7URXTrOw6dmbKn8bQnTUk6ch6L5SudnC8fz2HozNBVZlj7w9uq4Pwg7D1",
//            andWithAssigneeCode: "SDK",
//            andWithThemeColor:UIColor.red,
//            andIsThemeColorLight: false)
//
//        initialSetupViewController.didReceiveBackButtonCallback = {
//
//            self.viewModel.dismissHandler()
//        }
//
//        initialSetupViewController.didStartPreparePaymentPage = {
//            // Start Prepare Payment Page
//            // Show loading indicator
//        }
//        initialSetupViewController.didFinishPreparePaymentPage = {
//            // Finish Prepare Payment Page
//            // Stop loading indicator
//        }
//
//        initialSetupViewController.didReceiveFinishTransactionCallback = {(responseCode, result, transactionID, tokenizedCustomerEmail, tokenizedCustomerPassword, token, transactionState) in
//
//            var paymentStatus: Bool = false
//            var description: String = ""
//            var messgae: String = ""
//
//            if result == "Approved" && transactionID > 0 {
//                paymentStatus = true
//                description = "Payment successfully processed"
//                messgae = "Paymemt success"
//
//            } else {
//                paymentStatus = false
//                messgae = "Payment failure"
//                description = "something failure to payment failure"
//
//            }
//
//            let succesinfo = SuccessInfo(success: paymentStatus, message: messgae, paymentId: transactionID, description: description)
//            self.viewModel.paymentSuccess(info: succesinfo)
//        }
//        parentController.view.addSubview(initialSetupViewController.view)
//        parentController.addChild(initialSetupViewController)
//
//        initialSetupViewController.didMove(toParent: self.parentController)
    }
}
