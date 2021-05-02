//
//  UICollectionView.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 29/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    func registerNibForCellWithType<T: UICollectionViewCell>(type:T.Type) {
        let className = type.className
        let nib = UINib(nibName: type.className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as? T ?? nil
    }

    func reloadSafeItems(at indexPaths: [IndexPath]) {
        if self.isValid(indexPaths: indexPaths) {
            self.performBatchUpdates({
                self.reloadItems(at: indexPaths)
            }, completion: nil)
        } else {
            self.reloadData()
        }
    }
    
    func insetSafeItems(at indexPaths: [IndexPath]) {
        if self.isValidInsert(indexPaths: indexPaths) {
            self.performBatchUpdates({
                self.insertItems(at: indexPaths)
            }, completion: nil)
        } else {
            self.reloadData()
        }
    }

    
    func isValidInsert(indexPath: IndexPath) -> Bool {
        return indexPath.section < numberOfSections && indexPath.row <= numberOfItems(inSection: indexPath.section)
    }
    
    func isValid(indexPath: IndexPath) -> Bool {
        guard indexPath.section < numberOfSections,
            indexPath.item < numberOfItems(inSection: indexPath.section)
            else { return false }
        return true
    }
    
    func isValidInsert(indexPaths: [IndexPath]) -> Bool {
        if let first = indexPaths.first, isValidInsert(indexPath: first) {
            return true
        }
        return false
    }
    
    func isValid(indexPaths: [IndexPath]) -> Bool {
        if let first = indexPaths.first, isValid(indexPath: first),
            let last = indexPaths.last, isValid(indexPath: last) {
            return true
        }
        return false
    }
}
