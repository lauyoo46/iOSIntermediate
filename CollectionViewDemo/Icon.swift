//
//  Icon.swift
//  CollectionViewDemo
//
//  Created by Laurentiu Ile on 18/01/2021.
//

import UIKit

struct Icon {
    
    var name: String = ""
    var price: Double = 0.0
    var isFeatured: Bool = false
    var description: String = ""
    var imageName: String = ""
    
    init(name: String, price: Double, isFeatured: Bool, description: String, imageName: String) {
        self.name = name
        self.price = price
        self.isFeatured = isFeatured
        self.description = description
        self.imageName = imageName
    }
}
