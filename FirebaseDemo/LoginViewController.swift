//
//  LogonViewController.swift
//  FirebaseDemo
//
//  Created by Simon Ng on 14/12/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.title = "Log In"
        emailTextField.becomeFirstResponder()
    }

    @IBAction func login(sender: UIButton) {
        
        guard let emailAddress = emailTextField.text, emailAddress != "",
              let password = passwordTextField.text, password != "" else {
            
            let alertController = UIAlertController(title: "Login Error",
                                                    message: "Both fields must not be blank",
                                                    preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        Auth.auth().signIn(withEmail: emailAddress, password: password) { (result, error) in
            
            if let error = error {
                let alertController = UIAlertController(title: "LoginError",
                                                        message: error.localizedDescription,
                                                        preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            let message = """
                          You haven't confirmed your email address yet. We sent you a confirmation email when you sign up. Please click the verification link in that email. If you need us to send the confirmation email again, please tap Resend Email
                          """
            guard let result = result, result.user.isEmailVerified else {
                let alertController = UIAlertController(title: "Login Error",
                                                        message: message,
                                                        preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Resend email", style: .default) { (action) in
                    Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                alertController.addAction(okayAction)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            self.view.endEditing(true)
            
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                UIApplication.shared.keyWindow?.rootViewController = viewController
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
