//
//  CGFloat.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 30/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

public extension CGFloat {
    
    func roundedTowardZero(toPlaces places: Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return (self * divisor).rounded(.towardZero) / divisor
    }
    
}
