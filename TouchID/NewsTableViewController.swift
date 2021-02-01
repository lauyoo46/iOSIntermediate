//
//  NewsTableViewController.swift
//  TouchID
//
//  Created by Simon Ng on 25/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Home"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NewsTableViewCell
        
        guard let safeCell = cell else {
            return UITableViewCell()
        }

        if indexPath.row == 0 {
            safeCell.postImageView.image = UIImage(named: "red-lights-lisbon")
            safeCell.postTitle.text = "Red Lights, Lisbon"
            safeCell.postAuthor.text = "TOM EVERSLEY (@tomeversley)"
            safeCell.authorImageView.image = UIImage(named: "appcoda-fav-logo")
            
        } else if indexPath.row == 1 {
            safeCell.postImageView.image = UIImage(named: "val-throrens-france")
            safeCell.postTitle.text = "Val Thorens, France"
            safeCell.postAuthor.text = "BARA ART (bara-art.com)"
            safeCell.authorImageView.image = UIImage(named: "appcoda-fav-logo")
            
        } else if indexPath.row == 2 {
            safeCell.postImageView.image = UIImage(named: "summer-beach-huts")
            safeCell.postTitle.text = "Summer Beach Huts, England"
            safeCell.postAuthor.text = "TOM EVERSLEY (@tomeversley)"
            safeCell.authorImageView.image = UIImage(named: "appcoda-fav-logo")
            
        } else {
            safeCell.postImageView.image = UIImage(named: "taxis-nyc")
            safeCell.postTitle.text = "Taxis, NYC"
            safeCell.postAuthor.text = "TOM EVERSLEY (@tomeversley)"
            safeCell.authorImageView.image = UIImage(named: "appcoda-fav-logo")
        }
        
        return safeCell
    }
}
