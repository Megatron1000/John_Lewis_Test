//
//  PriceTests.swift
//  JohnLewisTest
//
//  Created by Mark Bridges on 24/04/2017.
//  Copyright © 2017 Mark Bridges. All rights reserved.
//

import XCTest
@testable import JohnLewisTest

class PriceTests: XCTestCase {
        
    func testPriceDeserialization() throws {
                
        let priceData = try Bundle(for: PriceTests.self).loadJSONData(resource: "price")!

        let price = try JSONDecoder().decode(Price.self, from: priceData)
        
        XCTAssertEqual(price.currency, "GBP")
        XCTAssertEqual(price.value, "329.00")
    }
    
    func testPriceDisplayString() {
        
        let price = Price(value: "123.45", currency: "GBP")
        
        XCTAssertEqual(price.displayString, "£123.45")
    }
    
}
