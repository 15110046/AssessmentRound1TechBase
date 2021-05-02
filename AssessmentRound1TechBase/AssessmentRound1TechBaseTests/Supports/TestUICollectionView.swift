//
//  TestUICollectionView.swift
//  AssessmentRound1TechBaseTests
//
//  Created by Azibai on 01/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit
@testable import AssessmentRound1TechBase

class TestUICollectionView: UICollectionView {
    var wasCallReloadData = false
    var wasCallScrollToItem = false
    var wasCallDequeue = false
    var dataModels: [[Any?]] = []
    class func initTestUICollectionView(with dataModels: [[Any]]) -> TestUICollectionView {
        let collectionView = TestUICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataModels = dataModels
        collectionView.reloadData()
        return collectionView
    }
    
    override func reloadData() {
        wasCallReloadData = true
        super.reloadData()
    }
    
    override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        wasCallDequeue = true
        return super.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }
    
    override func scrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        wasCallScrollToItem = true
        super.scrollToItem(at: indexPath, at: scrollPosition, animated: true)
    }

}
extension TestUICollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataModels.count
    }
    override func numberOfItems(inSection section: Int) -> Int {
        return dataModels[safe: section]?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModels[safe: section]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
