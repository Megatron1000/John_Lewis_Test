//
//  ProductsService.swift
//  NetAborter
//
//  Created by Mark Bridges on 24/11/2016.
//  Copyright © 2016 BridgeTech. All rights reserved.
//

import Foundation
import UIKit

class ProductsService {

    // MARK: Error Enums

    enum ProductsServiceError: Error {
        case undeserializableResponse
        case unexpectedResponse
    }

    // MARK: Result Enums

    enum RetreiveProductsResult {
        case success(products: [Product])
        case failure(error: Error)
    }

    enum RetreiveProductImageResult {
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

    func retrieveProducts(with completion: @escaping ((RetreiveProductsResult) -> Void)) {

        guard let url = URL(string: "https://api.johnlewis.com/v1/products/search?q=dishwasher&key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb&pageSize=20") else {
            fatalError("Unable to form URL for request")
        }

        httpClient.makeNetworkRequest(with: url, completion: { [weak self] result in

            DispatchQueue.main.async(execute: {

                guard let strongSelf = self else {
                    return
                }

                switch result {
                case .success(let data):

                    // Normally would do something a bit more fine grained than this
                    guard
                        let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                        let rootDictionary = jsonData as? [String:Any],
                        let productDictionaries = rootDictionary["products"] as? [[String:Any]] else {
                            completion(.failure(error: ProductsServiceError.unexpectedResponse))
                            return
                    }

                    let products: [Product] = productDictionaries.flatMap { productDictionary in
                        return Product(dictionary: productDictionary)
                    }

                    completion(.success(products: products))

                case .failure(let error):
                    completion(.failure(error: error))
                }

            })

        })
    }

    func retrieveImage(for product: Product, completion: @escaping ((RetreiveProductImageResult) -> Void)) {

        httpClient.makeNetworkRequest(with: product.image, completion: { result in

            DispatchQueue.main.async(execute: {

                switch result {
                case .success(let data):

                    guard
                        let image = UIImage(data: data) else {
                            completion(.failure(error: ProductsServiceError.unexpectedResponse))
                            return
                    }

                    completion(.success(productImage: image))

                case .failure(let error):
                    completion(.failure(error: error))

                }

            })

        })

    }

}
