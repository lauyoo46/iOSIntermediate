//
//  ViewController.swift
//  CustomFont
//
//  Created by Simon Ng on 18/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class FontViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let customFont1 = UIFont(name: "Singel Demo SemiBold", size: 28.0) {
            let fontMetrics = UIFontMetrics(forTextStyle: .title1)
            label1.font = fontMetrics.scaledFont(for: customFont1)
        }
        if let customFont2 = UIFont(name: "Hallo Sans", size: 20.0) {
            let fontMetrics = UIFontMetrics(forTextStyle: .headline)
            label2.font = fontMetrics.scaledFont(for: customFont2)
        }
        if let customFont3 = UIFont(name: "Canter Light", size: 17.0) {
            let fontMetrics = UIFontMetrics(forTextStyle: .subheadline)
            label3.font = fontMetrics.scaledFont(for: customFont3)
        }
        
        label1.adjustsFontForContentSizeCategory = true
        label2.adjustsFontForContentSizeCategory = true
        label3.adjustsFontForContentSizeCategory = true
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
