//
//  ProductsCollectionViewDataSource.swift
//  JohnLewisTest
//
//  Created by Mark Bridges on 24/04/2017.
//  Copyright © 2017 Mark Bridges. All rights reserved.
//

import UIKit

class ProductsCollectionViewDataSource: NSObject {
    
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
        
        let product = products[indexPath.row]
        
        guard
            let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else {
                fatalError("Wrong cell deqeued for identifier \(ProductCell.identifier)")
        }
        
        productCell.titleLabel.text = product.title
        productCell.priceLabel.text = product.price.displayString
        
        productsService.retrieveImage(for: product, completion: { result in
            switch result {
            case .success(let productImage):
                guard collectionView.indexPath(for: productCell) == indexPath else {
                    return // the cell was reused before we downloaded the image
                }
                productCell.imageView.image = productImage
                
            default:
                break
            }
        })
        
        return productCell
    }
    
}
