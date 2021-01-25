//
//  Trip.swift
//  TripCard
//
//  Created by Laurentiu Ile on 22/01/2021.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import UIKit
import Parse

struct Trip {
    
    var tripId = ""
    var city = ""
    var country = ""
    var featuredImage: PFFileObject?
    var price: Int = 0
    var totalDays: Int = 0
    var isLiked = false
    
    init(tripId: String, city: String, country: String, featuredImage: PFFileObject?, price: Int, totalDays: Int, isLiked: Bool) {
        self.tripId = tripId
        self.city = city
        self.country = country
        self.featuredImage = featuredImage
        self.price = price
        self.totalDays = totalDays
        self.isLiked = isLiked
    }
    
    func toPFObject() -> PFObject {
        let tripObject = PFObject(className: "Trip")
        tripObject.objectId = tripId
        tripObject["city"] = city
        tripObject["country"] = country
        tripObject["featuredImage"] = featuredImage
        tripObject["price"] = price
        tripObject["totalDays"] = totalDays
        tripObject["isLiked"] = isLiked
        return tripObject
    }
}
