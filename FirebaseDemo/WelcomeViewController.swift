//
//  WelcomeViewController.swift
//  FirebaseDemo
//
//  Created by Simon Ng on 5/1/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = ""
    }

    @IBAction func unwindtoWelcomeView(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
}
