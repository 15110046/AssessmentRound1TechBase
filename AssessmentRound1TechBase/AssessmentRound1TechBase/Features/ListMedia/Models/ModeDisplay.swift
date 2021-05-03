//
//  TypeDisplay.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 30/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

public enum ModeDisplay {
    
    case regular
    case compact
    
    init(string: String) {
        switch string {
        case "Regular": self = .regular
        case "Compact": self = .compact
        default:        self = .compact
        }
    }

    func getAllMode() -> [Self] {
        return [.regular, .compact]
    }
    
    var nameThumbnail: String {
        switch self {
        case .regular: return "120x120"
        case .compact: return "Square"
        }
    }
    
    var nameLayout: String {
        switch self {
        case .regular:
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:   return "Ipad-Portrait: \(column) column"
            case .phone: return "Iphone-Portrait: \(column) column"
            default:     return ""
            }
        case .compact:
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
        case .regular: return "Regular"
        case .compact: return "Compact"
        }
    }
    
    var column: Int {
        switch self {
        case .regular:
            switch UIDevice.current.userInterfaceIdiom {
            case .phone: return 1
            case .pad:   return 2
            default:     return 0
            }
        case .compact:
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
