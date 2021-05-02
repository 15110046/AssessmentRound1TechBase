//
//  BottomLoadingViewTest.swift
//  AssessmentRound1TechBaseUITests
//
//  Created by Azibai on 01/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import XCTest
@testable import AssessmentRound1TechBase

class BottomLoadingViewTest: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testExample() {
    }
}
//MARK: - Tests LoadView
extension BottomLoadingViewTest {
    
    func testIndicatorViewNotNilAfterLoad() {
        let view = BottomLoadingView(frame: .zero)
        XCTAssertNotNil(view.getIndicatorView())
    }
    
    func testIndicatorAnimationWhenDisplay() {
        let view = BottomLoadingView(frame: .zero)
        view.setHidden(false)
        XCTAssertTrue(view.getIndicatorView()?.isAnimating ?? false)
    }
}
