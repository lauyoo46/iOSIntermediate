//
//  AppDelegate.swift
//  GoogleAdDemo
//
//  Created by Simon Ng on 28/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true 
    }
    
}
