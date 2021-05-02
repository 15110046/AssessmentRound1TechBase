//
//  Collection.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 29/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

public extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
