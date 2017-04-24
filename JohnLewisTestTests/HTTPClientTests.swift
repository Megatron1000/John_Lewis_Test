//
//  HTTPClientTests.swift
//  NetAborter
//
//  Created by Mark Bridges on 27/11/2016.
//  Copyright © 2016 BridgeTech. All rights reserved.
//

import XCTest
@testable import NetAborter

class HTTPClientTests: XCTestCase {

    func testClientReturnsSuccessResultWhenThereIsValidDataAndNoError() {

        let mockedSession = NetworkSessionMock()
        mockedSession.completionResult = (Data(), nil, nil)

        let httpClient = HTTPClient(session: mockedSession)

        let myExpectation = expectation(description: "Call should complete")

        httpClient.makeNetworkRequest(with: URL(string:"http://www.anywhere.com")!, completion: { result in

            switch result {
            case .success(_):
                XCTAssert(true)

            default:
                XCTFail("Success response failed")
            }

            myExpectation.fulfill()
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testClientReturnsFailureResultWhenThereIsAnError() {

        let testError = ProductsService.ProductsServiceError.emptyResponse

        let mockedSession = NetworkSessionMock()
        mockedSession.completionResult = (nil, nil, testError)

        let httpClient = HTTPClient(session: mockedSession)

        let myExpectation = expectation(description: "Call should complete")

        httpClient.makeNetworkRequest(with: URL(string:"http://www.anywhere.com")!, completion: { result in

            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)

            default:
                XCTFail("Failure response succeeded")

            }

            myExpectation.fulfill()
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    // MARK: NetworkSessionMock

    class NetworkSessionMock: NetworkSession {

        var completionResult: (Data?, URLResponse?, Error?)?

        func startDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {

            guard let completionResult = completionResult else {
                fatalError("No completion handler set")
            }

            completionHandler(completionResult.0, completionResult.1, completionResult.2)

        }
    }

}
