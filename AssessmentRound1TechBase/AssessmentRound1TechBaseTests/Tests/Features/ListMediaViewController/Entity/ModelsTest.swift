//
//  ModelsTest.swift
//  AssessmentRound1TechBaseUITests
//
//  Created by Azibai on 01/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import XCTest
@testable import AssessmentRound1TechBase
@testable import SwiftyJSON

class ModelsTest: XCTestCase {
    
    override func setUp() {
    }

    override func tearDown() {
    }

    func testExample() {
    }
    
}

//MARK: - Test MediaModel
extension ModelsTest {
    func testGetNameSize() {
        let json = "{\"height\":3465.0,\"width\":123.0}"
        let model = MediaModel(json: JSON(parseJSON: json))
        let input = model.getNameSize()
        let output = "Size: 3465x123"
        XCTAssertEqual(input, output)
    }
}

//MARK: - Test ModeDisplay
extension ModelsTest {
    func testInitAlwayReturnCompactWhenStringOutSizeFormat() {
        let mode = ModeDisplay(string: "123123123")
        XCTAssertEqual(mode, ModeDisplay.compact)
    }

    func testGetAllMode() {
        let mode = ModeDisplay.regular.getAllMode()
        XCTAssertEqual(mode, [.regular, .compact])
    }
    
}
