//
//  MyNotificationConfigure.swift
//  NotificationSample
//
//  Created by Vijay on 08/07/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging


enum NotificationButtonActionidentifier: String {
    case investMore = "INVEST_MORE"
    case sip = "SIP"
    case redeem = "REDEEM"
    case none = ""
    
    
    init?(value: String){
        switch value {
        case "INVEST_MORE" : self = .investMore
        case "SIP" : self = .sip
        case "REDEEM" : self = .redeem
        case "": self = .none
        default : return nil
        }
    }
}


enum NotificationRedirectIdentfier: String {
    case watchlist
    case transaction
    case portfolio
}


protocol MyNotificationConfigureDelegate: class {
    func myNotification(configure: MyNotificationConfigure, didRedirectionScene: NotificationRedirectIdentfier, actionIdentifier: NotificationButtonActionidentifier, with info: [String: String])
}

class MyNotificationConfigure: NSObject,UNUserNotificationCenterDelegate,MessagingDelegate {
    
    static let shared = MyNotificationConfigure()
    
    weak var notificationDelegte: MyNotificationConfigureDelegate?
    private override init(){
        super.init()
        let configPath = Bundle.main.path(forResource: "GoogleService-Info", ofType: ".plist")!
        let options = FirebaseOptions(contentsOfFile: configPath)!
        FirebaseApp.configure(options: options)
        InAppMessaging.inAppMessaging().delegate = self
        Messaging.messaging().delegate = self
    }
    
    /// Check Notification Register or not
    func checkNotificationRegister() {
        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
            
            switch notificationSettings.authorizationStatus {
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.announcement,.badge,.criticalAlert,.providesAppNotificationSettings]) { (isSuccess, error) in
                    if error == nil && isSuccess {
                        print("Success")
                        self.addCategories()
                    }
                }
            case .authorized:
                print("Success notification registered")
                self.addCategories()
            case .provisional:
                print("Need to study")
            case .denied:
                print("Application Not Allowed to Display Notifications")
                
            default:
                print("Nothing")
            }
        }
        
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                print(result.instanceID)
                
            }
        }
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
          
        self.addCategories()
    }
    
    
    func addCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        let investMoreNotification = Notificationtype.investMore.category
        let redeemNotification = Notificationtype.redeem.category
        let sipeNotification = Notificationtype.sip.category
        center.setNotificationCategories([investMoreNotification,redeemNotification,sipeNotification])
    }
        
    func scheduleNotification(source: Notificationtype,bodyContent: BodyContentType) {
        let content = UNMutableNotificationContent() // Содержимое уведомления
        
        content.title = source.title
        content.body =  bodyContent.body
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = source.category.identifier
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let identifier = source.identifier
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        let category = UNNotificationCategory(identifier: source.category.identifier, actions:source.category.actions, intentIdentifiers: source.category.intentIdentifiers, options: source.category.options)
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print(deviceTokenString)
        UserDefaults.standard.set(deviceTokenString, forKey: "deviceToken")
        UserDefaults.standard.synchronize()
        Messaging.messaging().apnsToken = deviceToken

    }
    
    // codableConvert for
    func codableConvertModel<T: Codable>(fromData data: Data, returnType: T.Type, onCompletion:@escaping (Result<Codable, Error>) -> ()) {
        do {
            let decoder = try JSONDecoder().decode(returnType.self, from: data)
            onCompletion(.success(decoder))
        } catch {
            onCompletion(.failure(error))
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      

      // Print full message.
      print(userInfo)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.

      // Print full message.
      print(userInfo)        
      completionHandler(UIBackgroundFetchResult.newData)
    }

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let content = notification.request.content.userInfo
        print(content)
        completionHandler(.alert)
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        var actionName = ""
        switch response.actionIdentifier {
        case "INVEST_MORE":
            print("InvestMore action")
            actionName = "Invest More"
        case "REDEEM":
            print("redeem action")
             actionName = "Redeem"
        case "SIP":
            
           actionName = "SIP "
        default:
            print("Another")
        }
        
        let content = response.notification.request.content.userInfo
        
        codableConvertModel(fromData: content.convertData, returnType: NotificationInfo.self) { (result) in
            
            switch result {
            case .success(let codable):
                if let info = codable as? NotificationInfo {
                    print(info)
                    let redirectionParams = QueryParameters(url: URL(string: info.aps.redirection))
                    self.notificationDelegte?.myNotification(configure: self, didRedirectionScene: .watchlist, actionIdentifier: NotificationButtonActionidentifier(rawValue: response.actionIdentifier) ?? .none, with: redirectionParams.params)
                }
            case .failure(let error):
                print(error)
            }
        }
        print(response.notification.request.content.userInfo)
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "LinkViewController") as! LinkViewController
        controller.actionName = actionName
        UIApplication.shared.windows.last?.rootViewController?.present(controller, animated: true, completion: nil)
        
        completionHandler()
    }
    
}




extension MyNotificationConfigure: InAppMessagingDisplayDelegate {
    
    func messageClicked(_ inAppMessage: InAppMessagingDisplayMessage) {
        // ...
        print(InAppMessaging.inAppMessaging().messageDisplayComponent)
    }

    func messageDismissed(_ inAppMessage: InAppMessagingDisplayMessage,
                          dismissType: FIRInAppMessagingDismissType) {
        // ...
        print(InAppMessaging.inAppMessaging().messageDisplayComponent)

    }

    func impressionDetected(for inAppMessage: InAppMessagingDisplayMessage) {
        // ...
        print(InAppMessaging.inAppMessaging().messageDisplayComponent)
    }

    func displayError(for inAppMessage: InAppMessagingDisplayMessage, error: Error) {
        // ...
        print(error)
    }

}

extension Dictionary {
    
    var convertData: Data {
        let jsonData = try! JSONSerialization.data(withJSONObject: self, options: [])
        return jsonData
    }
}



extension URL {
    var queryParameters: QueryParameters { return QueryParameters(url: self) }
}

class QueryParameters {
    let queryItems: [URLQueryItem]
    init(url: URL?) {
        queryItems = URLComponents(string: url?.absoluteString ?? "")?.queryItems ?? []
        print(queryItems)
    }
    
    var params: [String: String] {
        var dict: [String: String] = [:]
        for i in queryItems.enumerated() {
            dict[i.element.name] = i.element.value ?? ""
        }
        return dict
    }
    
    subscript(name: String) -> String? {
        return queryItems.first(where: { $0.name == name })?.value
    }
}
