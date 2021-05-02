//
//  NSObject.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 01/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import Foundation

public extension NSObject {
    class var className: String {
        get {
            return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
        }
    }
}
