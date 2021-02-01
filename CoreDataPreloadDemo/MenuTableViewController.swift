//
//  MenuTableViewController.swift
//  CoreDataPreloadDemo
//
//  Created by Simon Ng on 7/11/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import CoreData

class MenuTableViewController: UITableViewController {

    private var menuItems:[MenuItem] = []
    var fetchResultController: NSFetchedResultsController<MenuItem>?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let request: NSFetchRequest<MenuItem> = MenuItem.fetchRequest()
            let context = appDelegate.persistentContainer.viewContext
            do {
                menuItems = try context.fetch(request)
            } catch {
                print("Failed to retrieve record")
                print(error)
            }
        }
        
        tableView.estimatedRowHeight = 66.0
        tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MenuTableViewCell else {
            return UITableViewCell()
        }

        cell.nameLabel.text = menuItems[indexPath.row].name
        cell.detailLabel.text = menuItems[indexPath.row].detail
        cell.priceLabel.text = "$\(menuItems[indexPath.row].price)"

        return cell
    }
}
