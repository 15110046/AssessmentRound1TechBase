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
    
    init(presenter: ListMediaDelegatePresenter?) {
        self.presenter = presenter
    }

    private func getWidthAfterSubInset(maxWidth: CGFloat,
                                       minimumInteritemSpacing: CGFloat,
                                       columnInteritem: CGFloat) -> CGFloat {
        let safePixel: CGFloat = 0.5
        return maxWidth - minimumInteritemSpacing*columnInteritem - safePixel
    }
}

// MARK: UIScrollViewDelegate
extension ListMediaCollectionViewDelegate: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        presenter?.suspendAllOperationsLoadMedia()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate,
        let collectionView = scrollView as? UICollectionView else { return }

        presenter?.loadImagesForOnscreenCells(at: collectionView.indexPathsForVisibleItems) { indexPaths in
            collectionView.reloadSafeItems(at: indexPaths)
        }
        presenter?.resumeAllOperationsLoadMedia()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let collectionView = scrollView as? UICollectionView else { return }
        presenter?.loadImagesForOnscreenCells(at: collectionView.indexPathsForVisibleItems) { indexPaths in
            collectionView.reloadSafeItems(at: indexPaths)
        }
        presenter?.resumeAllOperationsLoadMedia()
    }
        
}

// MARK: UICollectionViewDelegate
extension ListMediaCollectionViewDelegate: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let presenter = presenter else { return }
        
        if
            indexPath.item >= presenter.getDataSource().count - 1,
            !presenter.collectionViewIsFetchingData(),
            !presenter.stopRequestFetching {
            
            presenter.requestFetchData { (indexPaths) in
                collectionView.insetSafeItems(at: indexPaths)
            }
        }
    }

}

// MARK: UICollectionViewDelegateFlowLayout
extension ListMediaCollectionViewDelegate: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout,
            let model = presenter?.getDataSource()[safe: indexPath.item],
            let presenterCell = presenter?.presenterForCell(at: indexPath.item) else {
            return CGSize.zero
        }
        
        let maxW = getWidthAfterSubInset(
            maxWidth: collectionView.frame.width -
                collectionView.contentInset.right -
                collectionView.contentInset.left,
            minimumInteritemSpacing: flowLayout.minimumInteritemSpacing,
            columnInteritem: CGFloat(presenter?.getColumnInteritem(model: model) ?? 0))
        
        let width = presenterCell.getCellWidth(maxWidth: maxW)
        let height = presenterCell.getCellHeight(maxWidth: maxW)
        return CGSize(width: width, height: height).getSizeSafePixcel()
    }
    
}
