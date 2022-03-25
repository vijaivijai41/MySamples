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

class MyNotificationConfigure: NSObject,UNUserNotificationCenterDelegate,MessagingDelegate {
    
    static let shared = MyNotificationConfigure()
    
    private override init(){
        let configPath = Bundle.main.path(forResource: "GoogleService-Info", ofType: ".plist")!
        let options = FirebaseOptions(contentsOfFile: configPath)!
        FirebaseApp.configure(options: options)

    }
    
    /// Check Notification Register or not
    func checkNotificationRegister() {
        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
            
            switch notificationSettings.authorizationStatus {
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.announcement,.badge,.criticalAlert,.providesAppNotificationSettings]) { (isSuccess, error) in
                    if error == nil && isSuccess {
                        print("Success")
                        Messaging.messaging().delegate = self
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
            }
        }
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        
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
    
    
    //Notification Delegate update
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        
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
        completionHandler(.alert)
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        
        
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case "INVEST_MORE":
            print("InvestMore action")
            
        case "REDEEM":
            print("redeem action")
        case "SIP":
            
            print("monthly action")
        default:
            print("Another")
        }
        completionHandler()
    }
    
    
}
