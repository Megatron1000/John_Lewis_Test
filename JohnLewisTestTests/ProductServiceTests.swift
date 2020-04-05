//
//  ProductServiceTests.swift
//  JohnLewisTest
//
//  Created by Mark Bridges on 27/11/2016.
//  Copyright © 2016 BridgeTech. All rights reserved.
//

import XCTest
@testable import JohnLewisTest

class ProductServiceTests: XCTestCase {

    func testRetrieveProductsCallsTheCorrectURL() {

        let httpClientMock = HTTPClientMock()
        httpClientMock.mockedResult = HTTPClient.HTTPClientResult.success(data: Data())

        let productService = ProductsService(httpClient: httpClientMock)

        productService.retrieveProducts { _ in }

        XCTAssertEqual(httpClientMock.urlOfLastRequest, URL(string:"https://api.johnlewis.com/v1/products/search?q=dishwasher&key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb&pageSize=20"))
    }

    func testRetrieveProductsReturnsProducts() throws {

        let bundle = Bundle(for: ProductServiceTests.self)
        let jsonFixtureUrl = bundle.url(forResource: "products", withExtension: "json")!
        let data = try Data(contentsOf: jsonFixtureUrl)

        let httpClientMock = HTTPClientMock()
        httpClientMock.mockedResult = HTTPClient.HTTPClientResult.success(data: data)

        let productService = ProductsService(httpClient: httpClientMock)

        productService.retrieveProducts { result in

            switch result {
            case .success(let products):
                XCTAssertEqual(products.count, 20, "The products json fixture contains 20 items, we should have deserialized 20")

            default:
                XCTFail("Call with valid response failed")

            }
        }
    }

    func testRetrieveProductsReturnsAnErrorWithWhenTheCallFails() {

        let testError = ProductsService.ProductsServiceError.undeserializableResponse

        let httpClientMock = HTTPClientMock()
        httpClientMock.mockedResult = HTTPClient.HTTPClientResult.failure(error: testError)

        let productService = ProductsService(httpClient: httpClientMock)

        productService.retrieveProducts { result in

            switch result {
            case .failure(let error):
                switch error {
                    case ProductsService.ProductsServiceError.undeserializableResponse:
                    XCTAssert(true)

                default:
                    XCTFail("Wrong error return")

                }

            default:
                XCTFail("Call with invalid response succeeded")

            }
        }
    }


    // MARK: HTTPClientMock

    class HTTPClientMock: HTTPClient {

        var urlOfLastRequest: URL?
        var mockedResult: HTTPClientResult?

        override func makeNetworkRequest(with url: URL, completion: @escaping ((HTTPClientResult) -> Void)) {

            guard urlOfLastRequest == nil else {
                fatalError("HTTPClientMock called multiple times")
            }

            urlOfLastRequest = url

            guard let mockedResult = mockedResult else {
                fatalError("HTTPClientMock called with a mocked result to return")
            }

            completion(mockedResult)
        }
    }
    
}
