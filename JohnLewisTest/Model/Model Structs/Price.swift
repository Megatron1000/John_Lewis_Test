//
//  Price.swift
//  JohnLewisTest
//
//  Created by Mark Bridges on 24/04/2017.
//  Copyright © 2017 Mark Bridges. All rights reserved.
//

import Foundation

struct Price: Decodable {
    
    let value: String
    let currency: String
    
    private enum CodingKeys : String, CodingKey {
        case value = "now"
        case currency
    }
    
}

// MARK: Price String

extension Price {
    
    var displayString: String {
        // Test assumes it's always GBP
        return "£\(value)"
    }
    
}
