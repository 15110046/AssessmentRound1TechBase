//
//  DateTest.swift
//  AssessmentRound1TechBaseUITests
//
//  Created by Azibai on 01/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import XCTest
@testable import AssessmentRound1TechBase

class TestCase {
    static let jsonModel = "{\"height\":3465.0,\"width\":123.0}"
}
extension TestCase {

    public struct Extensions {}
    public struct Features {}
}

extension TestCase.Extensions {
    public struct Date {}
    public struct NSObject {}
    public struct Collections {}
    public struct UICollectionView {}
    public struct CGFloat {}
    public struct CGSize {}
}

extension TestCase.Extensions.Date {
    public static let DateToStringInPuts: [Date] = [Date(timeIntervalSince1970: 1619846522),
                  Date(timeIntervalSince1970: 1419848293)
    ]
    public static let DateToStringInOutPuts: [String] = ["01/05/2021", "29/12/2014"]
}

extension TestCase.Extensions.NSObject {
    static let classNameInputs = [ExtensionsTest.self]
    static let classNameOutPuts: [String] = ["ExtensionsTest"]

}
extension TestCase.Extensions.Collections {
    static let collectionSafeSubscriptInputs: [([Int], Int)] = [([1,2,3,4,5,6], 2), ([10, 9, -3, 3, 0], -1)]
    static let collectionSafeSubscriptOutputs: [Int?] = [3, nil]

}

extension TestCase.Extensions.UICollectionView {
}

extension TestCase.Extensions.CGFloat {
    static let roundedTowardZeroInputs: [CGFloat] = [0.8733, 12.38373, -123.11111, 0.6666667]
    static let roundedTowardZeroOutputs: [CGFloat] = [0.8, 12.3, -123.1, 0.6]
}

extension TestCase.Extensions.CGSize {
    static let sizeSafePixcelInputs: [CGSize] = [CGSize(width: 720, height: 414), CGSize(width: 244.6666667, height: 414)]
    static let sizeSafePixcelOutputs: [CGSize] = [CGSize(width: 720, height: 414), CGSize(width: 244.6, height: 414)]

}
