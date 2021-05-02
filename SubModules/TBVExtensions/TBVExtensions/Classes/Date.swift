//
//  Date.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 28/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import Foundation

public extension Date {
    func toString(withFormat format: String = "dd/MM/yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
}
