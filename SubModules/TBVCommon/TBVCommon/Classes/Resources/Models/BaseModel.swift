//
//  BaseModel.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 28/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import SwiftyJSON

open class BaseModel: NSObject {

    public var id: Int?
    public var finalHeight: CGFloat = -1
    public var finalWidth: CGFloat = -1
    
    open func clearSize() {
        finalHeight = -1
        finalWidth = -1
    }
    open func customInit() {
        
    }
    
    public override init() {
        super.init()
        self.customInit()
    }

    public init(json: JSON) {
        
    }
    
    deinit {
        print("======= \(String(describing: self))  deinit ====")
    }
    
}
