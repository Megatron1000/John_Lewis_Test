//
//  Product.swift
//  JohnLewisTest
//
//  Created by Mark Bridges on 24/04/2017.
//  Copyright © 2017 Mark Bridges. All rights reserved.
//

import Foundation

struct Product {
    
    let productId: String
    let price: Price
    let title: String
    let image: URL
    
}

// MARK: Deserializable

extension Product: Deserializable {
    
    init?(dictionary: [String:Any]) {
        
        // Normally might think about making this initialiser throwable instead of failable
        guard
            let productId = dictionary["productId"] as? String,
            let title = dictionary["title"] as? String,
            let priceDictionary = dictionary["price"] as? [String:Any],
            let price = Price(dictionary: priceDictionary),
            let imageURLString = dictionary["image"] as? String,
            /// The image URLs are missing a http prefix
            let image = URL(string: "https:" + imageURLString) else {
                return nil
        }
        
        self.productId = productId
        self.price = price
        self.title = title
        self.image = image
        
    }
    
}
