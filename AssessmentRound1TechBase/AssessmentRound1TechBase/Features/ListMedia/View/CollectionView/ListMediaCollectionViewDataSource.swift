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
    weak var delegate: ListMediaViewDelegate?
    
    init(presenter: ListMediaDataSourcePresenter?, delegate: ListMediaViewDelegate?) {
        self.presenter = presenter
        self.delegate = delegate
    }
    
}

extension ListMediaCollectionViewDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getNumberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let delegate = delegate,
            let cell = presenter?.cellForItemAt(indexPath: indexPath, delegate: delegate) as? UICollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
}
