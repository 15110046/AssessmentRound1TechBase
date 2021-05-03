//
//  ListMediaCollectionViewDelegate.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 29/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

class ListMediaCollectionViewDelegate: NSObject {
    
    weak var presenter: ListMediaDelegatePresenter?
    weak var delegate: ListMediaViewDelegate?
    
    init(presenter: ListMediaDelegatePresenter?, delegate: ListMediaViewDelegate?) {
        self.presenter = presenter
        self.delegate = delegate
    }
    
}

// MARK: UIScrollViewDelegate
extension ListMediaCollectionViewDelegate: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        presenter?.suspendAllOperationsLoadMedia()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard
            let delegate = delegate,
            let collectionView = scrollView as? UICollectionView else { return }
        
        presenter?.collectionViewScroll(decelerate: decelerate, indexPathsVisible: collectionView.indexPathsForVisibleItems, delegate: delegate)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard
            let delegate = delegate,
            let collectionView = scrollView as? UICollectionView else { return }
        presenter?.collectionViewDidEndDecelerating(indexPathsVisible: collectionView.indexPathsForVisibleItems, delegate: delegate)
    }
    
}

// MARK: UICollectionViewDelegate
extension ListMediaCollectionViewDelegate: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let delegate = delegate else { return }
        presenter?.collectionViewWillDisplay(forItemAt: indexPath, delegate: delegate)
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension ListMediaCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize.zero
        }
        
        let maxWidth = presenter?.getWidthAfterSubInset(
            at: indexPath,
            maxWidth: collectionView.frame.width -
                collectionView.contentInset.right -
                collectionView.contentInset.left,
            minimumInteritemSpacing: flowLayout.minimumInteritemSpacing)

        return presenter?.collectionViewSizeForItem(maxWidth: maxWidth ?? 0, at: indexPath) ?? .zero
    }
    
}
