//
//  NotificayionActionSource.swift
//  NotificationSample
//
//  Created by Vijay on 08/07/20.
//  Copyright © 2020 Vijay. All rights reserved.

import Foundation
import UIKit

protocol NotificationCategoryActionSource {
    var actionIdentifier: String { get }
    var actionTitle: String { get }
    var actionOption: UNNotificationActionOptions { get }
}

extension NotificationCategoryActionSource {
    var action: UNNotificationAction {
        return UNNotificationAction(identifier: self.actionIdentifier, title: self.actionTitle, options: self.actionOption)
    }
}



enum ActionTypes: NotificationCategoryActionSource {
    case investMore
    case redeem
    case sip
    
    var actionTitle: String {
        switch self {
        case .investMore:
            return "Invest More"
        case .redeem:
            return "Redeem"
        case .sip:
            return "Sip"
        }
    }
    
    var actionIdentifier: String {
        switch self {
        case .investMore:
            return "INVEST_MORE"
        case .redeem:
            return "REDEEM"
        case .sip:
            return "SIP"
        }
    }
    
    
    var actionOption: UNNotificationActionOptions {
        switch self {
        case .investMore:
            return []
        case .redeem:
            return []
        case .sip:
            return []
        }
        
    }
}




