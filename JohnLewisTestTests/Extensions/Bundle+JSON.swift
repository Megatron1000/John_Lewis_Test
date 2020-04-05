//
//  Bundle+JSON.swift
//  JohnLewisTest
//
//  Created by Mark Bridges on 24/04/2017.
//  Copyright © 2017 Mark Bridges. All rights reserved.
//

import Foundation

extension Bundle {
        
    func loadJSONData(resource: String) throws -> Data? {
        if let jsonPath = url(forResource: resource, withExtension: "json") {
            return try? Data(contentsOf: jsonPath)
        } else {
            return nil
        }
    }
    
}
