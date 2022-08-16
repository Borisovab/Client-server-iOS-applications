//
//  AppDelegate.swift
//  VKclient
//
//  Created by Александр Борисов on 03.06.2022.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let notificationCenter = UNUserNotificationCenter.current()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // устанавливаем цвет неактивных иконок в Tabbar
        UITabBar.appearance().unselectedItemTintColor = .blue

        // создаем уведомление, которое, при запуске программы, спрашивает разрешение на использование уведомление
        notificationCenter.requestAuthorization(options: [.alert, .sound, .alert]) { (granred, error) in

            guard granred else { return }
            self.notificationCenter.getNotificationSettings { (settings) in
                guard settings.authorizationStatus == .authorized else { return }
            }
        }

        notificationCenter.delegate = self
        sendNotifications()

        print("file path")
        print(Realm.Configuration.defaultConfiguration.fileURL)

        return true
    }

    // создаем функцию, с помощью которой будем отправлять новую нотификацию
    func sendNotifications() {

        let content = UNMutableNotificationContent()
        content.title = "Добро пожаловать!"
        content.body = "Пожалуйста, авторизируйтесь"
        content.sound = UNNotificationSound.default


        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)


        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
            print(error?.localizedDescription)
        }
    }


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

// расширяем класс, добавляя методы, чтобы уведомление приходило не только, когда приложение свернуто, но и когда оно активно, то есть на экране
extension AppDelegate: UNUserNotificationCenterDelegate {

    // когда приложение открыто
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }

    //    // срабатывает, когда нажимаем на уведомление. В этом методе можно задавать действия, которые сработают при нажатии на уведомление.
    //    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    //        print(#function)
    //    }


}
