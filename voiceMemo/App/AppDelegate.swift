//
//  AppDelegate.swift
//  voiceMemo
//
//  Created by Terry on 2023/10/12.
//

import UIKit

class AppDelegate:NSObject, UIApplicationDelegate {
    var notificationDelegate = NotificationDelegate()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = notificationDelegate

        return true 
    }
}
