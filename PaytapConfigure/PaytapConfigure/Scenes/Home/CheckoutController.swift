//
//  CheckoutController.swift
//  PaytapConfigure
//
//  Created by Vijay on 10/06/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit

class CheckoutController: UITableViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var amountText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var mobileTxt: UITextField!
    @IBOutlet weak var proceedButton: UIButton!
    
    var viewModel: CheckoutViewModel!
    
    var initialSetupViewController: PTFWInitialSetupViewController!

    var paymentController: PTFWOperationPrepareTransaction!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
   
    @IBAction func proceedButtonDidTap(_ sender: UIButton) {
        
        self.paymentController = PTFWOperationPrepareTransaction()
        
        let bundle = Bundle(url: Bundle.main.url(forResource: "Resources", withExtension: "bundle")!)
        self.initialSetupViewController = PTFWInitialSetupViewController.init(
            bundle: bundle,
            andWithViewFrame: self.view.frame,
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

        self.view.addSubview(initialSetupViewController.view)
        self.addChild(initialSetupViewController)
        
        initialSetupViewController.didMove(toParent: self)
//        let userName = usernameTxt.text ?? ""
//        let email = emailText.text ?? ""
//        let mobile = mobileTxt.text ?? ""
//        let amount = amountText.text ?? ""
//
//        if ValidationModel.checkoutValidation(username: userName, amount: amount, email: email, mobile: mobile) {
//            let chekputInfo = CheckoutInfo(amount: amount, customerTitle: userName, mobile: mobile, email: email)
//            viewModel.proccedButonDidTap(info: chekputInfo)
//        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

}

extension CheckoutController: CheckoutViewModelDelegte {
    func checkoutViewModel(viewModel: CheckoutViewModel, didProccedPayment info: CheckoutInfo) {
        
    }
    
    func checkoutViewModel(viewMoel: CheckoutViewModel, didFailure error: String) {
        
    }
}



