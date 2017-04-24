//
//  Bundle+JSON.swift
//  JohnLewisTest
//
//  Created by Mark Bridges on 24/04/2017.
//  Copyright © 2017 Mark Bridges. All rights reserved.
//

import Foundation

extension Bundle {
    
    /// Load JSON object from a file with .json extension
    func loadJSON<T>(for name: String) -> T? {
        guard
            let jsonPath = url(forResource: name, withExtension: "json"),
            let fileContents = try? Data(contentsOf: jsonPath) else {
            return nil
        }
        
        return (try? JSONSerialization.jsonObject(with: fileContents, options: JSONSerialization.ReadingOptions.allowFragments)) as? T
    }
    
}
