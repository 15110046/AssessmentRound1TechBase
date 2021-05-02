//
//  TypeDisplay.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 30/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

public enum ModeDisplay {
    
    case Regular
    case Compact
    
    init(string: String) {
        switch string {
        case "Regular": self = .Regular
        case "Compact": self = .Compact
        default:        self = .Compact
        }
    }

    func getAllMode() -> [Self] {
        return [.Regular, .Compact]
    }
    
    var nameThumbnail: String {
        switch self {
        case .Regular: return "120x120"
        case .Compact: return "Square"
        }
    }
    
    var nameLayout: String {
        switch self {
        case .Regular:
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:   return "Ipad-Portrait: \(column) column"
            case .phone: return "Iphone-Portrait: \(column) column"
            default:     return ""
            }
        case .Compact:
            switch UIDevice.current.userInterfaceIdiom {
            case .phone: return "Iphone-Portrait: \(column) column"
            case .pad:
                if UIDevice.current.orientation.isLandscape {
                    return "Ipad-Landscape: \(column) column"
                }
                return "Ipad-Portrait: \(column) column"
            default: return ""
            }
        }
    }
    
    var name: String {
        switch self {
        case .Regular: return "Regular"
        case .Compact: return "Compact"
        }
    }
    
    var column: Int {
        switch self {
        case .Regular:
            switch UIDevice.current.userInterfaceIdiom {
            case .phone: return 1
            case .pad:   return 2
            default:     return 0
            }
        case .Compact:
            switch UIDevice.current.userInterfaceIdiom {
            case .phone: return 2
            case .pad:
                if UIDevice.current.orientation.isLandscape {
                    return 5
                }
                return 3
            default: return 0
            }
        }
    }
}
