//
//  SidebarMenu.swift
//  SlidebarMenu
//
//  Created by Laurentiu Ile on 21/01/2021.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addSideBarMenu(leftMenuButton: UIBarButtonItem?, rightMenuButton: UIBarButtonItem? = nil) {
        if revealViewController() != nil {
            
            if let menuButton = leftMenuButton {
                menuButton.target = revealViewController()
                menuButton.action = #selector(SWRevealViewController.revealToggle(animated:))
            }
            
            if let extraButton = rightMenuButton {
                revealViewController().rightViewRevealWidth = 150
                extraButton.target = revealViewController()
                extraButton.action = #selector(SWRevealViewController.rightRevealToggle(animated:))
            }
            
            if let gesture = self.revealViewController().panGestureRecognizer() {
                view.addGestureRecognizer(gesture)
            }
        }
    }
}
