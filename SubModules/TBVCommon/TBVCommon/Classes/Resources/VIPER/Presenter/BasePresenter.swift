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
