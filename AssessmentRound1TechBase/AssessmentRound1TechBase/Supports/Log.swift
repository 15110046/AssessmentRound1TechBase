//
//  Log.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 01/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import Foundation

public func log(_ string: CustomStringConvertible, file: String = #file, line: Int = #line) {
    guard let fileName = file.components(separatedBy: "/").last else {
        print("==>>> L\(line) T\(Thread.current)] \(string)")
        return }
    let date = Date().toString(withFormat: "HH:mm:ss")
    print("==>>> [\(date) \(fileName) L\(line) T\(Thread.current)] \(string)")
}
