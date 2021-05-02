//
//  BaseMediaCollectionViewCellTest.swift
//  AssessmentRound1TechBaseUITests
//
//  Created by Azibai on 01/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import XCTest
@testable import AssessmentRound1TechBase

class BaseMediaCollectionViewCellTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testExample() {
    }

}

//MARK: -Test loadUI
extension BaseMediaCollectionViewCellTests {
    func testNotNilMediaImageView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.registerNibForCellWithType(type: MediaHorizontalCollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(withClass: MediaHorizontalCollectionViewCell.self, for: IndexPath(item: 0, section: 0))
        XCTAssertNotNil(cell?.getImageView())
    }
    
    func testNotNilAuthorLabel() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.registerNibForCellWithType(type: MediaHorizontalCollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(withClass: MediaHorizontalCollectionViewCell.self, for: IndexPath(item: 0, section: 0))
        XCTAssertNotNil(cell?.getAuthorLabel())
    }
    
    func testNotNilSizeLabel() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.registerNibForCellWithType(type: MediaHorizontalCollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(withClass: MediaHorizontalCollectionViewCell.self, for: IndexPath(item: 0, section: 0))
        XCTAssertNotNil(cell?.getSizeLabel())
    }
    
    func testNotNilContainerView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.registerNibForCellWithType(type: MediaHorizontalCollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(withClass: MediaHorizontalCollectionViewCell.self, for: IndexPath(item: 0, section: 0))
        XCTAssertNotNil(cell?.getContainerView())
    }
    
}
