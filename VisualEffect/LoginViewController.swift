//
//  LoginViewController.swift
//  VisualEffect
//
//  Created by Simon Ng on 24/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    
    private let imageSet = ["cloud", "coffee", "food", "pmq", "temple"]
    private var blurEffectView: UIVisualEffectView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selectedImageIndex = Int(arc4random_uniform(5))
        
        backgroundImageView.image = UIImage(named: imageSet[selectedImageIndex])
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        guard let safeBlurEffectView = blurEffectView else {
            return
        }
        backgroundImageView.addSubview(safeBlurEffectView)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        blurEffectView?.frame = view.bounds
    }
}
