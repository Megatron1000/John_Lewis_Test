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
        
    func testProductDeserialization() {
        
        let productDictionary: [String:Any] = Bundle(for: PriceTests.self).loadJSON(for: "product")!
        
        let product = Product(dictionary: productDictionary)
        
        XCTAssertEqual(product?.productId, "1913267")
        XCTAssertEqual(product?.title, "Bosch SMS53M02GB Freestanding Dishwasher, White")
        XCTAssertEqual(product?.image.absoluteString, "https://johnlewis.scene7.com/is/image/JohnLewis/234326367?")
        XCTAssertNotNil(product?.price)

    }

    
}
