//
//  Data.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 02/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import Foundation

public extension Data {

    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
