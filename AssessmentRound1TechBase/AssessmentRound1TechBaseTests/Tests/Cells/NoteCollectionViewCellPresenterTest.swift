//
//  NoteCollectionViewCellPresenterTest.swift
//  AssessmentRound1TechBaseTests
//
//  Created by Azibai on 02/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import AssessmentRound1TechBase

class NoteCollectionViewCellPresenterTest: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testExample() {
    }

}
extension NoteCollectionViewCellPresenterTest {
    func testCalCulateHeightCell() {
        let cellPresenter = NoteCollectionViewCellPresenter(modeDisplay: .regular, dataModel: NoteModel())
        let input = cellPresenter.calculateHeightCell(maxWidth: 300)
        let out: CGFloat = 120
        XCTAssertEqual(input, out)
    }
    
    func testCalCulateWidthCell() {
        let cellPresenter = NoteCollectionViewCellPresenter(modeDisplay: .regular, dataModel: NoteModel())
        let input = cellPresenter.calculateWidthCell(maxWidth: 414)
        let out: CGFloat = 414
        XCTAssertEqual(input, out)
    }
    
    func testGetCellNameNotReturnNull() {
        let cellPresenter = NoteCollectionViewCellPresenter(modeDisplay: .regular, dataModel: NoteModel())
        let input = cellPresenter.getCellName()
        XCTAssertNotNil(input)
    }
    
    func testStringAttributes() {
        let mode = ModeDisplay.compact
        let cellPresenter = NoteCollectionViewCellPresenter(modeDisplay: .regular, dataModel: NoteModel())
        let input = cellPresenter.getAttributedString(type: mode)
        let output = mode.name + " Cell" + "\nThumbnail Size: \(mode.nameThumbnail)" + "\nLayout:\n \t+\(mode.nameLayout)"
        XCTAssertEqual(input.string, output)
    }

}
