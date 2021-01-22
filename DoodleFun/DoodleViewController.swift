//
//  DoodleViewController.swift
//  DoodleFun
//
//  Created by Simon Ng on 12/11/2019.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit

class DoodleViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    private var doodleImages = ["DoodleIcons-1", "DoodleIcons-2", "DoodleIcons-3", "DoodleIcons-4",
                                "DoodleIcons-5", "DoodleIcons-6", "DoodleIcons-7", "DoodleIcons-8",
                                "DoodleIcons-9", "DoodleIcons-10", "DoodleIcons-11", "DoodleIcons-12",
                                "DoodleIcons-13", "DoodleIcons-14", "DoodleIcons-15", "DoodleIcons-16",
                                "DoodleIcons-17", "DoodleIcons-18", "DoodleIcons-19", "DoodleIcons-20"]
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.reloadData()
    }
}

extension DoodleViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodleImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? DoodleCollectionViewCell
        
        if let safeCell = cell {
            safeCell.imageView.image = UIImage(named: doodleImages[indexPath.row])
            
            return safeCell
        }
        
        return UICollectionViewCell()
    }
}

extension DoodleViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideSize = (traitCollection.horizontalSizeClass == .compact &&
                        traitCollection.verticalSizeClass == .regular) ? 80.0 : 128.0
        return CGSize(width: sideSize, height: sideSize)
    }
}
