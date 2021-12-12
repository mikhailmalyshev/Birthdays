//
//  AppDelegate.swift
//  Birthdays
//
//  Created by Михаил Малышев on 29.11.2021.
//

import UIKit
import CoreData
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
    
    func sendNotification() {
//        let date = Date(timeIntervalSinceNow: 10)
        var firstDate = DateComponents(month: 12, day: 12)

        firstDate.hour = 23
        firstDate.minute = 26
        
        let content = UNMutableNotificationContent()
        content.title = "Put your title Here (birthday)"
        content.body = "notification"
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: firstDate, repeats: true)
        
        let request = UNNotificationRequest(identifier: "Notificaion", content: content, trigger: trigger)
        
        notificatiocCenter.add(request) { error in
            print(error?.localizedDescription)
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Birthdays")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
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
