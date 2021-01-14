//
//  SceneDelegate.swift
//  TextReader
//
//  Created by Laurentiu Ile on 14/01/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let safeURL = URLContexts.first?.url else {
            return
        }
        let message = safeURL.host?.removingPercentEncoding
        let alertController = UIAlertController(title: "Incoming Message", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(okAction)
        window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
}
