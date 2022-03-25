//
//  CheckoutInfo.swift
//  PaytapConfigure
//
//  Created by Vijay on 06/06/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import Foundation

struct CheckoutInfo {
    
    let amount: String
    let customerTitle: String
    let mobile: String
    let email: String
}

struct SuccessInfo {
    let success: Bool
    let message: String
    let paymentId: Int32
    let description: String
}
