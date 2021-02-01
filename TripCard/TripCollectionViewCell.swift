//
//  TripCollectionViewCell.swift
//  TripCard
//
//  Created by Laurentiu Ile on 22/01/2021.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import UIKit

class TripCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var totalDaysLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
   
    var delegate: TripCollectionViewCellDelegate?
    
    var isLiked: Bool = false {
        didSet {
            if isLiked {
                likeButton.setImage(UIImage(named: "heartfull"), for: .normal)
            } else {
                likeButton.setImage(UIImage(named: "heart"), for: .normal)
            }
        }
    }
    
    @IBAction func likeButtonTapped(sender: AnyObject) {
        delegate?.didLikeButtonPressed(cell: self)
    }
}

protocol TripCollectionViewCellDelegate {
    func didLikeButtonPressed(cell: TripCollectionViewCell)
}
