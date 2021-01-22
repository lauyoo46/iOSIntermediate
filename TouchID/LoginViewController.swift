//
//  LoginViewController.swift
//  TouchID
//
//  Created by Simon Ng on 25/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    @IBOutlet weak var backgroundImageView:UIImageView!
    @IBOutlet weak var loginView:UIView!
    @IBOutlet weak var emailTextField:UITextField!
    @IBOutlet weak var passwordTextField:UITextField!
    
    private var imageSet = ["cloud", "coffee", "food", "pmq", "temple"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let selectedImageIndex = Int(arc4random_uniform(5))
        
        backgroundImageView.image = UIImage(named: imageSet[selectedImageIndex])
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        loginView.isHidden = true
        authenticateWithBiometric()
    }
    
    @IBAction func authenticateWithPassword() {
        
        if emailTextField.text == "hi@appcoda.com" && passwordTextField.text == "1234" {
            performSegue(withIdentifier: "showHomeScreen", sender: nil)
        } else {
            loginView.transform = CGAffineTransform(translationX: 25, y: 0)
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           usingSpringWithDamping: 0.15,
                           initialSpringVelocity: 0.3,
                           options: .curveEaseInOut,
                           animations: {
                            
                self.loginView.transform = CGAffineTransform.identity
                            
            }, completion: nil)
        }
        
    }
    
    func authenticateWithBiometric() {
        
        let localAuthContext = LAContext()
        let reasonText = "Authentication is required to sign in"
        var authError: NSError?
        
        if !localAuthContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            
            if let error = authError {
                print(error.localizedDescription)
            }
            showLoginDialog()
            return
        }
        
        localAuthContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                                        localizedReason: reasonText,
                                        reply: { (success: Bool, error: Error?) -> Void in
                                            
            if !success {
                if let error = error {
                    
                    switch error {
                    case LAError.authenticationFailed:
                        print("Authentication failed")
                    case LAError.passcodeNotSet:
                        print("Passcode not set")
                    case LAError.systemCancel:
                        print("Authentication was canceled by system")
                    case LAError.userCancel:
                        print("Authentication was canceled by the user")
                    case LAError.biometryNotEnrolled:
                        print("Authentication could not start because you haven't enrolled either Touch ID or Face ID on your device.")
                    case LAError.biometryNotAvailable:
                        print("Authentication could not start because Touch ID / Face ID is not available.")
                    case LAError.userFallback:
                        print("User tapped the fallback button (Enter Password).")
                    default:
                        print(error.localizedDescription)
                    }
                }
                
                OperationQueue.main.addOperation {
                    self.showLoginDialog()
                }
                
            } else {
                OperationQueue.main.addOperation {
                    self.performSegue(withIdentifier: "showHomeScreen", sender: nil)
                }
            }
        })
    }

    // MARK: - Helper methods

    func showLoginDialog() {

        loginView.isHidden = false
        loginView.transform = CGAffineTransform(translationX: 0, y: -700)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
            
            self.loginView.transform = CGAffineTransform.identity
            
        }, completion: nil)
        
    }
}
