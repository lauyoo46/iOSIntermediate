//
//  Icon.swift
//  CollectionViewDemo
//
//  Created by Laurentiu Ile on 18/01/2021.
//

import Foundation

struct Icon {
    
    var name: String = ""
    var price: Double = 0.0
    var isFeatured: Bool = false
    
    init(name: String, price: Double, isFeatured: Bool) {
        self.name = name
        self.price = price
        self.isFeatured = isFeatured
    }
}
