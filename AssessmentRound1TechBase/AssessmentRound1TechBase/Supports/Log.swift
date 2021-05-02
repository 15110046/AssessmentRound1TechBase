//
//  Log.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 01/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import Foundation

public func Log(_ s: CustomStringConvertible, file: String = #file, line: Int = #line) {
    let fileName = file.components(separatedBy: "/").last!
    let date = Date().toString(withFormat: "HH:mm:ss")
    print("==>>> [\(date) \(fileName) L\(line) T\(Thread.current)] \(s)")
}
