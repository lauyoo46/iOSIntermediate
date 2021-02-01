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
        preloadData()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataPreloadDemo")
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

extension AppDelegate {
    
    func parseCSV(contentsOfURL: URL, encoding: String.Encoding) -> [(name: String, detail: String, price: String)]? {
        
        let delimiter = ","
        var items:[(name:String, detail:String, price: String)]?
        
        do {
            let content = try String(contentsOf: contentsOfURL, encoding: encoding)
            items = []
            let lines: [String] = content.components(separatedBy: .newlines)
            
            for line in lines {
                var values: [String] = []
                if line != "" {
                    
                    if line.range(of: "\"") != nil {
                        var textToScan: String = line
                        var value: NSString?
                        var textScanner: Scanner = Scanner(string: textToScan)
                        
                        while textScanner.string != "" {
                            
                            if (textScanner.string as NSString).substring(to: 1) == "\"" {
                                textScanner.scanLocation += 1
                                textScanner.scanUpTo("\"", into: &value)
                                textScanner.scanLocation += 1
                            } else {
                                textScanner.scanUpTo(delimiter, into: &value)
                            }
                            
                            if let value = value {
                                values.append(value as String)
                            }
                            
                            if textScanner.scanLocation < textScanner.string.count {
                                textToScan = (textScanner.string as NSString).substring(from: textScanner.scanLocation + 1)
                            } else {
                                textToScan = ""
                            }
                            textScanner = Scanner(string: textToScan)
                        }
                    } else {
                        values = line.components(separatedBy: delimiter)
                    }
                    
                    let item = (name: values[0], detail: values[1], price: values[2])
                    items?.append(item)
                }
            }
        } catch {
            print(error)
        }
        
        return items
    }
    
    func preloadData() {
        guard let contentsOfURL = URL(string: "https://drive.google.com/uc?export=download &id=0ByZhaKOAvtNGelJOMEdhRFo2c28") else {
            return
        }
        
        removeData()
        
        if let items = parseCSV(contentsOfURL: contentsOfURL, encoding: String.Encoding.utf8) {
            let context = persistentContainer.viewContext
            
            for item in items {
                let menuItem = MenuItem(context: context)
                menuItem.name = item.name
                menuItem.detail = item.detail
                menuItem.price = Double(item.price) ?? 0.0
                
                do {
                    try context.save()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func removeData() {
        let fetchRequest = NSFetchRequest<MenuItem>(entityName: "MenuItem")
        let context = persistentContainer.viewContext
        
        do {
            let menuItems = try context.fetch(fetchRequest)
            
            for menuItem in menuItems {
                context.delete(menuItem)
            }
            saveContext()
        } catch {
            print(error)
        }
    }
}
