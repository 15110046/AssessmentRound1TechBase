//
//  ListMediaCollectionViewDataSource.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 29/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

class ListMediaCollectionViewDataSource: NSObject {
    
    weak var presenter: ListMediaDataSourcePresenter?
    
    init(presenter: ListMediaDataSourcePresenter?) {
        self.presenter = presenter
    }
    
}

extension ListMediaCollectionViewDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getNumberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let presenterCell = presenter?.presenterForCell(at: indexPath.item) else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: presenterCell.getCellName(), for: indexPath)
        
        if let cellViewInterface = cell as? CellViewInterface {
            cellViewInterface.loadCell(presenterCell)
        }
        
        if let modelModel = presenter?.getDataSource()[safe: indexPath.item] as? MediaModel {
            presenter?.startLoadMedia(for: modelModel, indexPath: indexPath, completion: { (indexPaths) in
                collectionView.reloadSafeItems(at: indexPaths)
            })
        }

        return cell
    }
    
}
