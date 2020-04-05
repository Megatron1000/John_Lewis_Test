//
//  ProductsCollectionViewController.swift
//  JohnLewisTest
//
//  Created by Mark Bridges on 24/04/2017.
//  Copyright © 2017 Mark Bridges. All rights reserved.
//

import UIKit

final class ProductsCollectionViewController: UICollectionViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet var productDataSource: ProductsCollectionViewDataSource!
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productDataSource.reloadData { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async(execute: {
                    self?.collectionView?.reloadData()
                })
                
            case .failure(let error):
                DispatchQueue.main.async(execute: {
                    let alertController = UIAlertController(title: "ERROR",
                                                            message: error.localizedDescription,
                                                            preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.present(alertController, animated: true, completion: nil)
                })
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
}

// MARK: Layout Delegate

extension ProductsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Displays the items in a 4 by 2 grid (with 4 items always on the longside)
        let longSideItemsCount: CGFloat = 4
        let shortSideItemsCount: CGFloat = 2
        
        let isLandscape = collectionView.frame.size.width > collectionView.frame.size.height
        
        let horizontalItemCount: CGFloat = isLandscape ? longSideItemsCount : shortSideItemsCount
        let verticalItemCount: CGFloat = isLandscape ? shortSideItemsCount : longSideItemsCount
        
        // Account for adding a 1 pixel gap between each cell
        let horizontalWhiteSpace = horizontalItemCount - 1
        let verticalWhiteSpace = verticalItemCount - 1
        let availableWidth: CGFloat = collectionView.frame.size.width - horizontalWhiteSpace
        let availableHeight: CGFloat = collectionView.frame.size.height - (collectionView.contentInset.top + verticalWhiteSpace)
        
        return CGSize(width: availableWidth / horizontalItemCount, height: availableHeight / verticalItemCount)
    }
    
}
