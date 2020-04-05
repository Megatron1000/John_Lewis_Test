//
//  ProductsCollectionViewDataSource.swift
//  JohnLewisTest
//
//  Created by Mark Bridges on 24/04/2017.
//  Copyright © 2017 Mark Bridges. All rights reserved.
//

import UIKit

final class ProductsCollectionViewDataSource: NSObject {
    
    // MARK: Results enum
    
    enum ProductsDataSourceResult {
        case success
        case failure(error: Error)
    }
    
    lazy fileprivate var productsService: ProductsService = {
        return ProductsService(httpClient: HTTPClient())
    }()
    
    fileprivate var products: [Product] = []
    
    // MARK: Data Reloading
    
    func reloadData(with completion: @escaping ((ProductsDataSourceResult) -> Void)) {
        
        productsService.retrieveProducts { [weak self] result in
            
            switch result {
                
            case .success(let products):
                self?.products = products
                completion(ProductsDataSourceResult.success)
                
            case .failure(let error):
                completion(ProductsDataSourceResult.failure(error: error))
                
            }
        }
    }
    
}

// MARK: UICollectionViewDataSource

extension ProductsCollectionViewDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else {
                fatalError("Unable dequeue cell for identifier \(ProductCell.identifier)")
        }
        
        let product = products[indexPath.row]
        
        productCell.titleLabel.text = product.title
        productCell.priceLabel.text = product.price.displayString
                
        return productCell
    }
    
}
