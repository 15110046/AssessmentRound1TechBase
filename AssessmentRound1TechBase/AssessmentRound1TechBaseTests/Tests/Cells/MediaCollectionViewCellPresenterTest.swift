//
//  MediaCollectionViewCellPresenterTest.swift
//  AssessmentRound1TechBaseTests
//
//  Created by Azibai on 02/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import AssessmentRound1TechBase

class MediaCollectionViewCellPresenterTest: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testExample() {
    }


}
extension MediaCollectionViewCellPresenterTest {
    func testCalCulateHeightCell() {
        let json = "{\"height\":3465.0,\"width\":123.0}"
        let cellPresenter = MediaCollectionViewCellPresenter(modeDisplay: .Regular, dataModel: MediaModel(json: JSON(parseJSON: json)))
        let input = cellPresenter.calculateHeightCell(maxWidth: 400)
        let out: CGFloat = 120
        XCTAssertEqual(input, out)
    }
    
    func testCalCulateWidthCell() {
        let json = "{\"height\":3465.0,\"width\":123.0}"
        let cellPresenter = MediaCollectionViewCellPresenter(modeDisplay: .Regular, dataModel: MediaModel(json: JSON(parseJSON: json)))
        let input = cellPresenter.calculateWidthCell(maxWidth: 240)
        let out: CGFloat = 240
        XCTAssertEqual(input, out)
    }
    
    func testGetCellNameNotReturnNull() {
        let json = "{\"height\":3465.0,\"width\":123.0}"
        let cellPresenter = MediaCollectionViewCellPresenter(modeDisplay: .Regular, dataModel: MediaModel(json: JSON(parseJSON: json)))
        let input = cellPresenter.getCellName()
        XCTAssertNotNil(input)
    }
}


