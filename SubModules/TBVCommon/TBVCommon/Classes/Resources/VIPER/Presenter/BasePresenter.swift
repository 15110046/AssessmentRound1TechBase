//
//  BasePresenter.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 28/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import Foundation
import TBVNetWork

open class BasePresenter: NSObject {
    
    public var networkIsWork: Bool {
        return Reachability.isConnectedToNetwork()
    }

}
public extension BasePresenter {
    
    struct Insets {
        public var top: Float
        public var left: Float
        public var bottom: Float
        public var right: Float
        
        public init(top: Float, left: Float, bottom: Float, right: Float) {
            self.top = top
            self.left = left
            self.bottom = bottom
            self.right = right
        }
    }
    
}
