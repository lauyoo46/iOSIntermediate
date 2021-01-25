//
//  AppDelegate.swift
//  TripCard
//
//  Created by Simon Ng on 8/11/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "woXpdcwtmTQRI1lXoV3r2TS3vPj4WXqegkgZemck"
            $0.clientKey = "sEs0TjV09wOc0qVebCa3dBQpTomhypEGXrIuh8Cx"
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: configuration)
        
        return true
    }
}
