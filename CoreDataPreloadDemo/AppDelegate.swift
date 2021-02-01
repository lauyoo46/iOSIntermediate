//
//  AppDelegate.swift
//  CoreDataPreloadDemo
//
//  Created by Simon Ng on 7/11/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let directoryUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let applicationDocumentDirectory = directoryUrls[0]
        let storeUrl = applicationDocumentDirectory.appendingPathComponent("CoreDataPreloadDemo.sqlite")
        
        if !FileManager.default.fileExists(atPath: storeUrl.path) {
            let sourceSqliteURLs = [Bundle.main.url(forResource: "CoreDataPreloadDemo", withExtension: "sqlite"),
                                    Bundle.main.url(forResource: "CoreDataPreloadDemo", withExtension: "sqlite-wal"),
                                    Bundle.main.url(forResource: "CoreDataPreloadDemo", withExtension: "sqlite-shm")]
            let destSqliteURLs = [applicationDocumentDirectory.appendingPathComponent( "CoreDataPreloadDemo.sqlite"),
                                  applicationDocumentDirectory.appendingPathComponent( "CoreDataPreloadDemo.sqlite-wal"),
                                  applicationDocumentDirectory.appendingPathComponent("CoreDataPreloadDemo.sqlite-shm")]
            for index in 0..<sourceSqliteURLs.count {
                do {
                    if let safeSourceSqliteURLs = sourceSqliteURLs[index] {
                        try FileManager.default.copyItem(at: safeSourceSqliteURLs, to: destSqliteURLs[index])
                    }
                } catch {
                    print(error)
                }
            }
        }
        
        let description = NSPersistentStoreDescription()
        description.url = storeUrl
        
        let container = NSPersistentContainer(name: "CoreDataPreloadDemo")
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)") }
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
