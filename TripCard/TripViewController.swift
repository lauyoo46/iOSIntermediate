//
//  TripViewController.swift
//  TripCard
//
//  Created by Simon Ng on 8/11/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import Parse

class TripViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    
    private var trips = [Trip]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView.image = UIImage(named: "cloud")
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        collectionView.backgroundColor = UIColor.clear
        
        if UIScreen.main.bounds.size.height == 568.0 {
            if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.itemSize = CGSize(width: 250.0, height: 330.0)
            }
        }
        
        loadTripsFromParse()
        setupSwipeGesture()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func loadTripsFromParse() {
        trips.removeAll()
        collectionView.reloadData()
        
        let query = PFQuery(className: "Trip")
        query.cachePolicy = PFCachePolicy.networkElseCache
        query.findObjectsInBackground { (objects, error) in
            
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            
            if let objects = objects {
                for (index, object) in objects.enumerated() {
                    
                    let tripId = object.objectId
                    let city = object["city"] as? String
                    let country = object["country"] as? String
                    let featuredImage = object["featuredImage"] as? PFFileObject
                    let price = object["price"] as? Int
                    let totalDays = object["totalDays"] as? Int
                    let isLiked = object["isLiked"] as? Bool
                    
                    let trip = Trip(tripId: tripId ?? "", city: city ?? "",
                                    country: country ?? "", featuredImage: featuredImage,
                                    price: price ?? 0, totalDays: totalDays ?? 0, isLiked: isLiked ?? false)
                    
                    self.trips.append(trip)
                    
                    let indexPath = IndexPath(row: index, section: 0)
                    self.collectionView.insertItems(at: [indexPath])
                }
            }
        }
    }
    
    func setupSwipeGesture() {
        let swipeUpRecognizer = UISwipeGestureRecognizer(target: self,
                                                         action: #selector(handleSwipe(gesture:)))
        swipeUpRecognizer.direction = .up
        swipeUpRecognizer.delegate = self
        self.collectionView.addGestureRecognizer(swipeUpRecognizer)
    }
    
    @IBAction func reloadButtonTapped(sender: Any) {
        loadTripsFromParse()
    }
}

extension TripViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? TripCollectionViewCell
        
        guard let safeCell = cell else {
            return UICollectionViewCell()
        }
        
        safeCell.delegate = self
        
        safeCell.cityLabel.text = trips[indexPath.row].city
        safeCell.countryLabel.text = trips[indexPath.row].country
        safeCell.priceLabel.text = "$\(String(trips[indexPath.row].price))"
        safeCell.totalDaysLabel.text = "\(trips[indexPath.row].totalDays) days"
        safeCell.isLiked = trips[indexPath.row].isLiked
        
        safeCell.imageView.image = UIImage()
        if let featuredImage = trips[indexPath.row].featuredImage {
            featuredImage.getDataInBackground { (imageData, error) in
                if let tripImageData = imageData {
                    safeCell.imageView.image = UIImage(data: tripImageData)
                }
            }
        }
        safeCell.layer.cornerRadius = 4.0
        
        return safeCell
    }
}

extension TripViewController: TripCollectionViewCellDelegate {
    
    func didLikeButtonPressed(cell: TripCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            trips[indexPath.row].isLiked = trips[indexPath.row].isLiked ? false : true
            cell.isLiked = trips[indexPath.row].isLiked
            
            trips[indexPath.row].toPFObject().saveInBackground()
        }
    }
}

extension TripViewController: UIGestureRecognizerDelegate {
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        let point = gesture.location(in: self.collectionView)
        
        if gesture.state == UIGestureRecognizer.State.ended {
            if let indexPath = collectionView.indexPathForItem(at: point) {
                trips[indexPath.row].toPFObject().deleteInBackground { (success, error) in
                    if success {
                        print("Successfully removed the trip")
                    } else {
                        print("Error: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }
                    
                    self.trips.remove(at: indexPath.row)
                    self.collectionView.deleteItems(at: [indexPath])
                }
            }
        }
    }
}
