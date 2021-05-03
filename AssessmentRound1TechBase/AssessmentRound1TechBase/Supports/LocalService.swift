//
//  LocalService.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 04/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import Foundation

public class LocalService {
    public static let shared = LocalService()
    
    public let keyChainService = KeyChainService()
    
    public class KeyChainService {
        public func getDataModeDisplayFromLocal() -> Data? {
            return KeyChain.loadSegmentData()
        }
        
        public func saveStateModeToLocal(string: String) {
            KeyChain.saveSegment(key: string)
        }
    }
}
