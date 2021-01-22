//
//  IconCollectionViewController.swift
//  CollectionViewDemo
//
//  Created by Laurentiu Ile on 18/01/2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class IconCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    private var shareEnabled = false
    private var selectedIcons: [(icon: Icon, snapshot: UIImage)] = []
    
    private var iconSet: [Icon] = [
        Icon(name: "Candle Icon", price: 3.99, isFeatured: false, description: "Halloween icon", imageName: "candle"),
        Icon(name: "Cat Icon", price: 2.99, isFeatured: true, description: "Halloween icon", imageName: "cat"),
        Icon(name: "Dribble Icon", price: 1.99, isFeatured: false, description: "Halloween icon", imageName: "dribbble"),
        Icon(name: "Ghost Icon", price: 4.99, isFeatured: false, description: "Halloween icon", imageName: "ghost"),
        Icon(name: "Hat Icon", price: 2.99, isFeatured: false, description: "Halloween icon", imageName: "hat"),
        Icon(name: "Owl Icon", price: 5.99, isFeatured: true, description: "Halloween icon", imageName: "owl"),
        Icon(name: "Pot Icon", price: 1.99, isFeatured: false, description: "Halloween icon", imageName: "pot"),
        Icon(name: "Pumkin Icon", price: 0.99, isFeatured: false, description: "Halloween icon", imageName: "pumkin"),
        Icon(name: "RIP Icon", price: 7.99, isFeatured: false, description: "Halloween icon", imageName: "rip"),
        Icon(name: "Skull Icon", price: 8.99, isFeatured: false, description: "Halloween icon", imageName: "skull"),
        Icon(name: "Sky Icon", price: 0.99, isFeatured: false, description: "Halloween icon", imageName: "sky"),
        Icon(name: "Toxic Icon", price: 2.99, isFeatured: false, description: "Halloween icon", imageName: "toxic"),
        Icon(name: "Book Icon", price: 2.99, isFeatured: false, description: "Halloween icon", imageName: "ic_book"),
        Icon(name: "BackPack Icon", price: 3.99, isFeatured: false, description: "Halloween icon", imageName: "ic_backpack"),
        Icon(name: "Camera Icon", price: 4.99, isFeatured: false, description: "Halloween icon", imageName: "ic_camera"),
        Icon(name: "Coffee Icon", price: 3.99, isFeatured: true, description: "Halloween icon", imageName: "ic_coffee"),
        Icon(name: "Glasses Icon", price: 3.99, isFeatured: false, description: "Halloween icon", imageName: "ic_glasses"),
        Icon(name: "Ice Cream Icon", price: 4.99, isFeatured: false, description: "Halloween icon", imageName: "ic_ice_cream"),
        Icon(name: "Smoking Pipe Icon", price: 6.99, isFeatured: false, description: "Halloween icon", imageName: "ic_smoking_pipe"),
        Icon(name: "Vespa Icon", price: 9.99, isFeatured: false, description: "Halloween icon", imageName: "ic_vespa")
    ]
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        
        guard shareEnabled == true else {
            shareEnabled = true
            collectionView.allowsMultipleSelection = true
            shareButton.title = "Done"
            shareButton.style = UIBarButtonItem.Style.plain
            return
        }
        
        guard !selectedIcons.isEmpty else {
            return
        }
        
        let snapshots = selectedIcons.map { $0.snapshot }
        
        let activityController = UIActivityViewController(activityItems: snapshots, applicationActivities: nil)
        activityController.completionWithItemsHandler = { (activityType, completed, returnedItem, error) in
            
            if let indexPaths = self.collectionView.indexPathsForSelectedItems {
                for indexPath in indexPaths {
                    self.collectionView.deselectItem(at: indexPath, animated: false)
                }
            }
            
            self.selectedIcons.removeAll(keepingCapacity: true)
            
            self.shareEnabled = false
            self.collectionView.allowsMultipleSelection = false
            self.shareButton.title = "Share"
            self.shareButton.style = UIBarButtonItem.Style.plain
        }
        
        present(activityController, animated: true, completion: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showIconDetail" {
            if shareEnabled == true {
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showIconDetail" {
            
            if let indexPaths = collectionView.indexPathsForSelectedItems,
               let destinationController = segue.destination as? IconDetailViewController {
                
                destinationController.icon = iconSet[indexPaths[0].row]
                collectionView.deselectItem(at: indexPaths[0], animated: false)
                
            }
        }
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {}
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconSet.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            as? IconCollectionViewCell
        
        if let safeCell = cell {
            let icon = iconSet[indexPath.row]
            safeCell.iconImageView.image = UIImage(named: icon.imageName)
            safeCell.iconPriceLabel.text = "$\(icon.price)"
            safeCell.backgroundView = icon.isFeatured ? UIImageView(image: UIImage(named: "feature-bg")) : nil
            safeCell.selectedBackgroundView = UIImageView(image: UIImage(named: "icon-selected"))
            
            return safeCell
        }
        
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard shareEnabled == true else {
            return
        }
        
        let selectedIcon = iconSet[indexPath.row]
        if let snapshot = collectionView.cellForItem(at: indexPath)?.snapshot {
            selectedIcons.append((icon: selectedIcon, snapshot: snapshot))
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard shareEnabled == true else {
            return
        }
        
        let deselectedIcon = iconSet[indexPath.row]
        if let index = selectedIcons.firstIndex(where: {$0.icon.name == deselectedIcon.name}) {
            selectedIcons.remove(at: index)
        }
    }
}
