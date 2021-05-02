//
//  PendingOperations.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 02/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import Foundation

class PendingOperations {
    var ramInDevice: Int {
        return Int(Double(ProcessInfo.processInfo.physicalMemory) / (1024.0 * 1024.0 * 1024.0))
    }
    lazy var downloadsInProgress: [IndexPath: Operation] = [:]
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = ramInDevice + 1
        return queue
    }()
    
    lazy var filtrationsInProgress: [IndexPath: Operation] = [:]
    lazy var filtrationQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Image Filtration queue"
        queue.maxConcurrentOperationCount =  ramInDevice + 1
        return queue
    }()
}
