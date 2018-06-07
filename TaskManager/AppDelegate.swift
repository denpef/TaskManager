//
//  AppDelegate.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        if let _ = UserDefaults.standard.object(forKey: "userNotificationsIsOn") {}
        else {
            UserDefaults.standard.set(true, forKey: "userNotificationsIsOn")
        }
    }
    func applicationWillTerminate(_ application: UIApplication) {
        TMPersistentService.saveContext()
    }


}

