//
//  CGSize.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 30/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

public extension CGSize {
    func getSizeSafePixcel() -> CGSize {
        return CGSize(width: (self.width).roundedTowardZero(toPlaces: 1), height: self.height)
    }
}
