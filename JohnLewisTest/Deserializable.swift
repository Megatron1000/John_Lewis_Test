//
//  Deserializable.swift
//  JohnLewisTest
//
//  Created by Mark Bridges on 24/04/2017.
//  Copyright © 2017 Mark Bridges. All rights reserved.
//

import Foundation


protocol Deserializable {
    
    init?(dictionary: [String : Any])
    
}
