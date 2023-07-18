//
//  PushManagerFactory.swift
//  bubbletime
//
//  Created by  savelii on 18.07.23.
//

import Foundation
import UserNotifications
import UIKit
protocol PushManagerFactory {
    func scheduleLocalNotification(title: String, body: String, timeInterval: TimeInterval)
    func requestPushAuthorization(openSettings: Bool, completion: @escaping () -> Void)
}
class PushManagerFactoryImp: NSObject, PushManagerFactory {
    func scheduleLocalNotification(title: String, body: String, timeInterval: TimeInterval) {
        let current = UNUserNotificationCenter.current()
        current.delegate = self
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = String(format: "\(body)", "\(Int(round(timeInterval)))")
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        let request = UNNotificationRequest(identifier: "notification\(Date().localDate())", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func requestPushAuthorization(openSettings: Bool, completion: @escaping () -> Void) {
        let current = UNUserNotificationCenter.current()

        current.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .notDetermined {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                    completion()
                    guard error == nil else {
                        return
                    }
                    if granted {
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                    }
                    else {
                
                    }
                }
            } else if settings.authorizationStatus == .denied && openSettings {
                if let bundleIdentifier = Bundle.main.bundleIdentifier, let appSettings = URL(string: UIApplication.openSettingsURLString + bundleIdentifier) {
                    DispatchQueue.main.async {
                        completion()
                        if UIApplication.shared.canOpenURL(appSettings) {
                            UIApplication.shared.open(appSettings)
                        }
                    }
                }
            } else if settings.authorizationStatus == .authorized {
                completion()
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        })
    }

}
extension PushManagerFactoryImp: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
          completionHandler([.alert, .sound])
      }
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
          completionHandler()
      }
}
