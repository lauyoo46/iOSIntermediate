//
//  SignUpViewController.swift
//  FirebaseDemo
//
//  Created by Simon Ng on 5/1/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sign Up"
        nameTextField.becomeFirstResponder()
    }
    
    @IBAction func registerAccount(sender: UIButton) {
        
        guard let name = nameTextField.text, name != "",
              let emailAddress = emailTextField.text, emailAddress != "",
              let password = passwordTextField.text, password != "" else {
            
            let alertController = UIAlertController(title: "Registration Error",
                                                    message: "Incomplete data for registration.",
                                                    preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        Auth.auth().createUser(withEmail: emailAddress, password: password) { (user, error) in
            
            if let error = error {
                let alertController = UIAlertController(title: "RegistrationError",
                                                        message: error.localizedDescription,
                                                        preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                changeRequest.displayName = name
                changeRequest.commitChanges { (error) in
                    if let error = error {
                        print("Failed to change the display name: \(error.localizedDescription)")
                    }
                }
            }
            
            self.view.endEditing(true)
            
            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                print("Failed to send verification email")
            })
            
            let message = """
                          We've just sent a confirmation email to your email address.
                          Please check your inbox and click the verification link in
                          that email to complete the sign up
                          """
            let alertController = UIAlertController(title: "Email verification",
                                                    message: message,
                                                    preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
