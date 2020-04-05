//
//  ProductTests.swift
//  JohnLewisTest
//
//  Created by Mark Bridges on 24/04/2017.
//  Copyright © 2017 Mark Bridges. All rights reserved.
//

import XCTest
@testable import JohnLewisTest

class ProductTests: XCTestCase {
        
    func testProductDeserialization() throws {
        
        let productData = try Bundle(for: PriceTests.self).loadJSONData(resource: "product")!
                
        let product = try JSONDecoder().decode(Product.self, from: productData)
        
        XCTAssertEqual(product.productId, "1913267")
        XCTAssertEqual(product.title, "Bosch SMS53M02GB Freestanding Dishwasher, White")
        XCTAssertNotNil(product.price)

    }

    
}
