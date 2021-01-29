//
//  AppDelegate.swift
//  FirebaseDemo
//
//  Created by Simon Ng on 14/12/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        customizeUIStyle()
        FirebaseApp.configure()
        return true
    }
}

extension AppDelegate {
    func customizeUIStyle() {
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Avenir", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
    }
}
