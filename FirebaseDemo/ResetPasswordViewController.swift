//
//  ResetPasswordViewController.swift
//  FirebaseDemo
//
//  Created by Simon Ng on 5/1/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Forgot Password"
        emailTextField.becomeFirstResponder()
    }

    @IBAction func resetPassword(sender: UIButton) {
        
        guard let emailAddress = emailTextField.text,
            emailAddress != "" else {
                
                let alertController = UIAlertController(title: "Input Error",
                                                        message: "Please provide your email address for password reset.",
                                                        preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                
                return
        }
        
        Auth.auth().sendPasswordReset(withEmail: emailAddress, completion: { (error) in
            
            let title = (error == nil) ? "Password Reset Follow-up" : "Password Reset Error"
            let message = (error == nil) ? "A confirmation email has been sent to the specified address." : error?.localizedDescription
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                
                if error == nil {
                    self.view.endEditing(true)
                    
                    if let navController = self.navigationController {
                        navController.popViewController(animated: true)
                    }
                }
            })
            alertController.addAction(okayAction)
            
            self.present(alertController, animated: true, completion: nil)
        })
    }
}
