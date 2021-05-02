//
//  ExtensionsTest.swift
//  AssessmentRound1TechBaseUITests
//
//  Created by Azibai on 01/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import XCTest
@testable import AssessmentRound1TechBase

class ExtensionsTest: XCTestCase {
    var vc = ListMediaViewController()

    override func setUp() {
        vc = ListMediaViewController.create(modeDisplay: .Regular, set: nil) as! ListMediaViewController
        vc.loadViewIfNeeded()
    }

    
    override func tearDown() {
    }
    
}

//MARK: Date
extension ExtensionsTest {
    func testDatetoStringValue() {
        let inputs = TestCase.Extensions.Date.DateToStringInPuts.map({ $0.toString()})
        let outputs = TestCase.Extensions.Date.DateToStringInOutPuts
        XCTAssertEqual(inputs, outputs)
    }
}

//MARK: NSOject
extension ExtensionsTest {
    func testClassNameValue() {
        let inputs = TestCase.Extensions.NSObject.classNameInputs.map({ $0.className })
        let outputs = TestCase.Extensions.NSObject.classNameOutPuts
        XCTAssertEqual(inputs, outputs)
    }
    
}

//MARK: Collections
extension ExtensionsTest {
    func testCollectionSafeSubscriptValue() {
        let inputs = TestCase.Extensions.Collections.collectionSafeSubscriptInputs.map({ $0.0[safe: $0.1] })
        let outputs = TestCase.Extensions.Collections.collectionSafeSubscriptOutputs
        XCTAssertEqual(inputs, outputs)
        
    }
}

//MARK: UICollectionView
extension ExtensionsTest {
    func testIsValidInsertIndexPathValue() {
        let clsView = TestUICollectionView.initTestUICollectionView(with: [[0,1,2,3,4,5,6]])
        let valid = clsView.isValidInsert(indexPath: IndexPath(item: 0, section: 0))
        let notValid = clsView.isValidInsert(indexPath: IndexPath(item: 0, section: 1))

        XCTAssertTrue(valid)
        XCTAssertFalse(notValid)
    }
    
    func testIsValidIndexPath() {
        let clsView = TestUICollectionView.initTestUICollectionView(with: [[0,1,2,3,4,5,6]])
        let valid = clsView.isValid(indexPath: IndexPath(item: 5, section: 0))
        let notValid = clsView.isValid(indexPath: IndexPath(item: 12, section: 0))

        XCTAssertTrue(valid)
        XCTAssertFalse(notValid)
    }
}

//MARK: CGFLoat
extension ExtensionsTest {
    func testRoundedTowardZero() {
        let input = TestCase.Extensions.CGFloat.roundedTowardZeroInputs.map({ $0.roundedTowardZero(toPlaces: 1)})
        let output = TestCase.Extensions.CGFloat.roundedTowardZeroOutputs
        
        XCTAssertEqual(input, output)
    }
}

//MARK: CGSize
extension ExtensionsTest {
    func testSizeSafePixcelColumnCollectionView() {
        let input = TestCase.Extensions.CGSize.sizeSafePixcelInputs
            .map({ $0.getSizeSafePixcel() })
        let output = TestCase.Extensions.CGSize.sizeSafePixcelOutputs
        XCTAssertEqual(input, output)
    }
}
 
//MARK: UIViewController
extension ExtensionsTest {
    func testParentViewController() {
        let input = vc.getCollectionView()?.parentViewController
        XCTAssertEqual(input, vc)
    }
}
