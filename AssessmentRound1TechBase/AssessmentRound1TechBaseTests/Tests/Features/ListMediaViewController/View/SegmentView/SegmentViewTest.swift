//
//  SegmentViewTest.swift
//  AssessmentRound1TechBaseUITests
//
//  Created by Azibai on 01/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import XCTest
@testable import AssessmentRound1TechBase

class SegmentViewTest: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testExample() {
    }

}
//MARK: - Tests LoadView
extension SegmentViewTest {
    func testSegmentViewNotNilAfterLoad() {
        let view = SegmentView(frame: .zero)
        XCTAssertNotNil(view.getSegmentView())
    }
    
    func testConfigSegmentItems() {
        let view = SegmentView(frame: .zero)
        view.configSegment(items: [.compact, .regular], selectedMode: .compact)
        XCTAssertEqual(view.getSegmentView()?.selectedSegmentIndex, 0)
    }
    
    func testSegmentConfigOutOfRangeNotCrash() {
        let view = SegmentView(frame: .zero)
        XCTAssertFalse(view.checkValid(items: [.regular, .regular], selectedMode: .compact))
    }
}
