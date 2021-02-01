//
//  MenuTableViewController.swift
//  SlideDownMenu
//
//  Created by Simon Ng on 27/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    var menuItems = ["Home", "News", "Tech", "Finance", "Reviews"]
    var currentItem = "Home"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let menuTableViewController = segue.source as? MenuTableViewController,
           let selectedIndexPath = menuTableViewController.tableView.indexPathForSelectedRow {
            currentItem = menuItems[selectedIndexPath.row]
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MenuTableViewCell
        
        guard let safeCell = cell else {
            return UITableViewCell()
        }

        safeCell.titleLabel.text = menuItems[indexPath.row]
        safeCell.titleLabel.textColor = (menuItems[indexPath.row] == currentItem) ? UIColor.white : UIColor.gray

        return safeCell
    }
}
