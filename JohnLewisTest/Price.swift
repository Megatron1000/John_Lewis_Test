//
//  Price.swift
//  JohnLewisTest
//
//  Created by Mark Bridges on 24/04/2017.
//  Copyright © 2017 Mark Bridges. All rights reserved.
//

import Foundation


struct Price {
    
    let value: String
    let currency: String
    
}

// MARK: Deserializable

extension Price: Deserializable {
    
    init?(dictionary: [String:Any]) {
        guard
            let now = dictionary["now"] as? String,
            let currency = dictionary["currency"] as? String else {
                return nil
        }

        self.value = now
        self.currency = currency
    }
    
}

// MARK: Price String

extension Price {
    
    var displayString: String {
        return "£\(value)"
    }
    
}
