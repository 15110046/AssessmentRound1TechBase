//
//  KeyChain.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 02/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import Foundation

extension KeyChain {
    
    public class func saveSegment(key: String) {
        let segment = ModeDisplay.init(string: key)
        let data = Data(from: segment)
        _ = KeyChain.save(key: SegmentKey, data: data)
    }
    
    public class func loadSegment() -> ModeDisplay {
        if let receivedData = KeyChain.load(key: SegmentKey) {
            let result = receivedData.to(type: ModeDisplay.self)
            return result
        }
        return .regular
    }
    
}
