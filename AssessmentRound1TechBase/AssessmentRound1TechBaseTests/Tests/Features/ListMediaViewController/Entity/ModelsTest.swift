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

//MARK: - Test NoteModel
extension ModelsTest {
    func testStringAttributes() {
        let model = NoteModel()
        let mode = ModeDisplay.Compact
        let input = model.getAttributedString(type: mode).string
        let output = mode.name + " Cell" + "\nThumbnail Size: \(mode.nameThumbnail)" + "\nLayout:\n \t+\(mode.nameLayout)"
        XCTAssertEqual(input, output)
    }
}

//MARK: - Test ModeDisplay
extension ModelsTest {
    func testInitAlwayReturnCompactWhenStringOutSizeFormat() {
        let mode = ModeDisplay(string: "123123123")
        XCTAssertEqual(mode, ModeDisplay.Compact)
    }

    func testGetAllMode() {
        let mode = ModeDisplay.Regular.getAllMode()
        XCTAssertEqual(mode, [.Regular, .Compact])
    }
    
//    func testGetMaxWitdhCollectionViewWithColumn() {
//        let mode = ModeDisplay.Regular
//        let input = mode.getMaxWitdh(collectionView: UICollectionView(frame: CGRect(x: 0, y: 0, width: 414, height: 720), collectionViewLayout: UICollectionViewFlowLayout()), columnExpected: 3)
//        let ouput: CGFloat = 383.5
//        XCTAssertEqual(input, ouput)
//    }
    
//    func testGetHeightForItemWithMediaModel() {
//        let mode = ModeDisplay.Compact
//
//        let model = MediaModel(json: JSON(parseJSON: ""))
//        let input = mode.getHeightForItem(UICollectionView(frame: CGRect(x: 0, y: 0, width: 414, height: 720), collectionViewLayout: UICollectionViewFlowLayout()), at: model)
//        let output: CGFloat = 249.75
//        XCTAssertEqual(input, output)
//    }
}
