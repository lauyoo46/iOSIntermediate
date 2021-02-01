//
//  Icon.swift
//  CollectionViewDemo
//
//  Created by Laurentiu Ile on 18/01/2021.
//

import UIKit
import Messages

public struct Icon {
    
    public var name: String = ""
    public var price: Double = 0.0
    public var isFeatured: Bool = false
    public var description: String = ""
    public var imageName: String = ""
    
    init(name: String, price: Double, isFeatured: Bool, description: String, imageName: String) {
        self.name = name
        self.price = price
        self.isFeatured = isFeatured
        self.description = description
        self.imageName = imageName
    }
}

public extension Icon {
    
    enum QueryItemKey: String {
        case name = "name"
        case imageName = "imageName"
        case description = "description"
        case price = "price"
    }
    
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        items.append(URLQueryItem(name: QueryItemKey.name.rawValue, value: name))
        items.append(URLQueryItem(name: QueryItemKey.imageName.rawValue, value: imageName))
        items.append(URLQueryItem(name: QueryItemKey.description.rawValue, value: description))
        items.append(URLQueryItem(name: QueryItemKey.price.rawValue, value: String (price)))
        return items
    }
    
    init(queryItems: [URLQueryItem]) {
        for queryItem in queryItems {
            guard let value = queryItem.value else { continue }
            if queryItem.name == QueryItemKey.name.rawValue {
                self.name = value
            }
            if queryItem.name == QueryItemKey.imageName.rawValue {
                self.imageName = value
            }
            if queryItem.name == QueryItemKey.description.rawValue {
                self.description = value
            }
            if queryItem.name == QueryItemKey.price.rawValue {
                self.price = Double(value) ?? 0.0
            }
        }
    }
}

public extension Icon {
    
    init?(message: MSMessage?) {
        guard let messageURL = message?.url,
              let urlComponents = URLComponents(url: messageURL, resolvingAgainstBaseURL: false),
              let queryItems = urlComponents.queryItems else {
            return nil
        }
        self.init(queryItems: queryItems)
    }
}
