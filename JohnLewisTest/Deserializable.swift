//
//  Deserializable.swift
//  JohnLewisTest
//
//  Created by Mark Bridges on 24/04/2017.
//  Copyright © 2017 Mark Bridges. All rights reserved.
//

import Foundation

/// Declares that the conforming object can be initialised with a dictionary
protocol Deserializable {
    
    init?(dictionary: [String : Any])
    
}
