//
//  NotificationCategory.swift
//  NotificationSample
//
//  Created by Vijay on 08/07/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import Foundation
import UIKit



protocol NotificationContents {
    var body: String { get }
}

public enum BodyContentType: NotificationContents {
    
    case investMore
    case redeem
    case sip

    var body: String {
        switch self {
        case .investMore:
            return "Your investment allocation for TCS you want to more investment"
        case .redeem:
            return "Your redemption was successfull do you want to continue to invest more"
        case .sip:
            return "Your monthly sip for enable today do you want to continue to proceed."
        }
    }
}







protocol NotificationCategoryProtocal {
    var identifier: String { get }
    var title: String { get }
    var option: UNNotificationCategoryOptions { get }
}

enum Notificationtype: NotificationCategoryProtocal {
      case investMore
      case redeem
      case sip
    
    var identifier: String  {
        switch self {
        case .investMore:
            return "Invest More"
        case .redeem:
            return "Redeem"
        case .sip:
            return "Monthly SIP"
        }
    }
    
    var title: String {
        switch self {
        case .investMore:
            return "Invest more"
        case .redeem:
            return "Redeem"
        case .sip:
            return "Monthly SIP"
        }
    }
    
    var option: UNNotificationCategoryOptions {
        return .hiddenPreviewsShowSubtitle
    }
    
    var category: UNNotificationCategory  {
        switch self {
        case .investMore:
            let investMoreAction = [ActionTypes.investMore.action, ActionTypes.redeem.action]
            return UNNotificationCategory(identifier:Notificationtype.investMore.identifier, actions: investMoreAction, intentIdentifiers: [], options:Notificationtype.investMore.option)
            
        case .redeem:
            let redeemAction = [ActionTypes.redeem.action]
            return UNNotificationCategory(identifier:Notificationtype.redeem.identifier, actions: redeemAction, intentIdentifiers: [], options:Notificationtype.redeem.option)
        case .sip:
            let sipAction = [ActionTypes.sip.action, ActionTypes.investMore.action]
            return UNNotificationCategory(identifier:Notificationtype.sip.identifier, actions: sipAction, intentIdentifiers: [], options:Notificationtype.sip.option)
        }
        
    }
}


