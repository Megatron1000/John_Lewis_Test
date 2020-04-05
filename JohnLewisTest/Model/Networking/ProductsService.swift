//
//  ProductsService.swift
//  JohnLewisTest
//
//  Created by Mark Bridges on 24/11/2016.
//  Copyright © 2016 BridgeTech. All rights reserved.
//

import Foundation
import UIKit

final class ProductsService {

    // MARK: Error Enums

    enum ProductsServiceError: Error {
        case undeserializableResponse
        case unexpectedResponse
    }

    // MARK: Result Enums

    enum  RetrieveProductsResult {
        case success(products: [Product])
        case failure(error: Error)
    }

    enum  RetrieveProductImageResult {
        case success(productImage: UIImage)
        case failure(error: Error)
    }

    // MARK: Properties

    let httpClient: HTTPClient

    // MARK: Initialisation

    required init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    // MARK: Network calls

    func retrieveProducts(with completion: @escaping (( RetrieveProductsResult) -> Void)) {

        guard let url = URL(string: "https://api.johnlewis.com/v1/products/search?q=dishwasher&key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb&pageSize=20") else {
            fatalError("Unable to form URL for request")
        }

        httpClient.makeNetworkRequest(with: url, completion: { result in

                switch result {
                case .success(let data):
                    do {
                        let productsResponse: ProductsResponse = try JSONDecoder().decode(ProductsResponse.self, from: data)
                        completion(.success(products: productsResponse.products))
                    } catch {
                        completion(.failure(error: error))
                    }

                case .failure(let error):
                    completion(.failure(error: error))
                }

        })
    }

}

private struct ProductsResponse: Decodable {
    let products: [Product]
}
