//
//  AppDelegate.swift
//  Birthdays
//
//  Created by Михаил Малышев on 29.11.2021.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let notificatiocCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        notificatiocCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granded, error in
            
            guard granded else { return }
            self.notificatiocCenter.getNotificationSettings { settings in
                print(settings)
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
        notificatiocCenter.delegate = self
        sendNotification()
        return true
    }
    
    private func sendNotification() {
        let friends = StorageManager.shared.fetchFriends()
        
        for friend in friends {
            var notificationDate = DateComponents(month: friend.birthdate.month,
                                                  day: friend.birthdate.day)
            notificationDate.hour = 9
            notificationDate.minute = 0
            let content = UNMutableNotificationContent()
            content.title = "Hey! Don't forget!"
            content.body = "Today is \(friend.burthDayDescription())'s birthday!"
            content.sound = UNNotificationSound.default
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: notificationDate, repeats: true)
            
            let request = UNNotificationRequest(identifier: "Notificaion", content: content, trigger: trigger)
            
            notificatiocCenter.add(request) { error in
                print(error?.localizedDescription ?? "error")
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
        print(#function)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
}
