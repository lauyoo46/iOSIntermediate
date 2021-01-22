//
//  NewsTableViewCell.swift
//  GoogleAdDemo
//
//  Created by Simon Ng on 29/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var postImageView:UIImageView!
    @IBOutlet var postTitle:UILabel!
    @IBOutlet var postAuthor:UILabel!
    @IBOutlet var authorImageView:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        authorImageView.layer.cornerRadius = authorImageView.frame.width / 2
        authorImageView.layer.masksToBounds = true
    }
}
