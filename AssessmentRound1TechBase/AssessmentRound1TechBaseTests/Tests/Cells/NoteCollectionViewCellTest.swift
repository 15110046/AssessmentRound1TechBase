//
//  NoteCollectionViewCellTest.swift
//  AssessmentRound1TechBaseTests
//
//  Created by Azibai on 01/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import XCTest
@testable import AssessmentRound1TechBase

class NoteCollectionViewCellTest: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testExample() {
    }

}

//MARK: -Test loadUI
extension NoteCollectionViewCellTest {
    func testNoteLabelNotNil() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.registerNibForCellWithType(type: NoteCollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(withClass: NoteCollectionViewCell.self, for: IndexPath(item: 0, section: 0))
        XCTAssertNotNil(cell?.getNoteLabel())
    }
}
