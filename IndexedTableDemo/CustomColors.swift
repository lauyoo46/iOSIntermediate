//
//  CustomColors.swift
//  IndexedTableDemo
//
//  Created by Laurentiu Ile on 11/01/2021.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import UIKit

enum CustomColors {
    
    case myGray
    case myOrange
    
    var uiColor: UIColor {
        switch self {
        
        case .myGray:
            return UIColor(red: 236.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1.0)
        case .myOrange:
            return UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        }
    }
}
