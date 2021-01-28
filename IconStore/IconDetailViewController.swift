//
//  IconDetailViewController.swift
//  IconStore
//
//  Created by Laurentiu Ile on 28/01/2021.
//

import UIKit
import IconDataKit

class IconDetailViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.text = icon?.name
        }
    }
    
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = icon?.description
        }
    }
    
    @IBOutlet var iconImageView: UIImageView! {
        didSet {
            iconImageView.image = UIImage(named: icon?.imageName ?? "")
        }
    }
    
    @IBOutlet var priceLabel: UILabel! {
        didSet {
            if let icon = icon {
                priceLabel.text = "$\(icon.price)" }
        }
    }
    
    var icon: Icon?
}
