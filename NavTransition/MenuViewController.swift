//
//  MenuViewController.swift
//  NavTransition
//
//  Created by Simon Ng on 26/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var transitionImages = ["Doodle Icons-41", "Doodle Icons-42", "Doodle Icons-43", "Doodle Icons-44"]
    var transitions = ["Slide Down", "Slide Right", "Pop", "Rotate"]
    
    let slideDownTransition = SlideDownTransitionAnimator()
    let slideRightTransition = SlideRightTransitionAnimator()
    let popTransition = PopTransitionAnimator()
    let rotateTransition = RotateTransitionAnimator()
    
    @IBOutlet var collectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let toViewController = segue.destination
        guard let sourceViewController = segue.source as? MenuViewController else {
            return
        }
        
        toViewController.modalPresentationStyle = .fullScreen
        sourceViewController.modalPresentationStyle = .fullScreen
        
        if let selectedIndexPaths = sourceViewController.collectionView.indexPathsForSelectedItems {
            switch selectedIndexPaths[0].row {
            
            case 0: toViewController.transitioningDelegate = slideDownTransition
                
            case 1: toViewController.transitioningDelegate = slideRightTransition
                
            case 2: toViewController.transitioningDelegate = popTransition
                
            case 3: toViewController.transitioningDelegate = rotateTransition
                    
            default: break
            }
        }
    }

    // MARK: - UICollectionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return transitionImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MenuCell
        
        cell.thumbnailImageView.image = UIImage(named: transitionImages[indexPath.row])
        cell.titleLabel.text = transitions[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular) ? 80.0 : 100.0
        let height = (traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular) ? 105.0: 130.0
        
        return CGSize(width: width, height: height)
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.reloadData()
    }
}
