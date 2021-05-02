//
//  NoteModel.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 30/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

class NoteModel: BaseModel {
    
    func getAttributedString(type: ModeDisplay) -> NSMutableAttributedString {
        let atts: NSMutableAttributedString =
            NSMutableAttributedString(string: type.name + " Cell",
                                      attributes: getConvenienceAttributes(color: .black,
                                                                           font: UIFont.systemFont(ofSize: 21, weight: .bold)))
        
        let thumbnailAtt: NSAttributedString = NSAttributedString(string: "\nThumbnail Size: \(type.nameThumbnail)", attributes: getConvenienceAttributes(color: .black, font: .systemFont(ofSize: 17, weight: .bold)))
        let layoutAtt: NSAttributedString = NSAttributedString(string: "\nLayout:\n \t+\(type.nameLayout)", attributes: getConvenienceAttributes(color: .black, font: .systemFont(ofSize: 14, weight: .medium)))
        
        atts.append(thumbnailAtt)
        atts.append(layoutAtt)
        return atts
    }
    
    
    func getConvenienceAttributes(color: UIColor, font: UIFont) -> [NSAttributedString.Key : Any] {
        [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor : color]
    }
}
