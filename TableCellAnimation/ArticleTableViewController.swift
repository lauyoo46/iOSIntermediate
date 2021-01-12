//
//  ArticleTableViewController.swift
//  TableCellAnimation
//
//  Created by Simon Ng on 3/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {
    
    let postTitles = ["Use Background Transfer Service To Download File in Background",
                      "Face Detection in iOS Using Core Image",
                      "Building a Speech-to-Text App Using Speech Framework in iOS 10",
                      "Building Your First Web App in Swift Using Vapor",
                      "Creating Gradient Colors Using CAGradientLayer",
                      "A Beginner's Guide to CALayer"];
    let postImages = ["imessage-sticker-pack",
                      "face-detection-featured",
                      "speech-kit-featured",
                      "vapor-web-framework",
                      "cagradientlayer-demo",
                      "calayer-featured"];

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 258.0
        tableView.rowHeight = UITableView.automaticDimension
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postTitles.count
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
        cell.layer.transform = rotationTransform
        UIView.animate(withDuration: 1.0, animations: { cell.layer.transform = CATransform3DIdentity })
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArticleTableViewCell
        cell.titleLabel.text = postTitles[(indexPath as NSIndexPath).row]
        cell.postImageView.image = UIImage(named: postImages[(indexPath as NSIndexPath).row])

        return cell
    }
}
