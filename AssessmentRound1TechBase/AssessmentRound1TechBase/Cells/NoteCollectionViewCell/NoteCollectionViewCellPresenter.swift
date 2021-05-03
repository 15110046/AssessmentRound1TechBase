//
//  NoteCollectionViewCellPresenter.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 02/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

class NoteCollectionViewCellPresenter: BaseCellPresenter {
    
    private(set) var modeDisplay: ModeDisplay
    private(set) var dataModel: NoteModel
    
    init(modeDisplay: ModeDisplay, dataModel: NoteModel) {
        self.modeDisplay = modeDisplay
        self.dataModel = dataModel
        super.init()
    }
    
    override func getCellName() -> String {
        return "NoteCollectionViewCell"
    }
    
    override func calculateHeightCell(maxWidth: CGFloat) -> CGFloat {
        
        if dataModel.finalHeight == -1 {
            switch modeDisplay {
            case .regular:
                let constHeightCellRegular: CGFloat = 120
                dataModel.finalHeight = constHeightCellRegular
            case .compact:
                let constHeightText: CGFloat = 48
                dataModel.finalHeight = maxWidth/CGFloat(modeDisplay.column) + constHeightText
            }
        }
        return dataModel.finalHeight
    }
    
    override func calculateWidthCell(maxWidth: CGFloat) -> CGFloat {
        if dataModel.finalWidth == -1 {
            switch modeDisplay {
            case .regular:
                dataModel.finalWidth = (maxWidth)/CGFloat(modeDisplay.column)
            case .compact:
                let surplus: Int = Constants.LimitItemInBlock % modeDisplay.column
                let ratio: CGFloat = CGFloat(modeDisplay.column-surplus)/CGFloat(modeDisplay.column)
                let output: CGFloat = ratio*maxWidth
                dataModel.finalWidth = output
            }
        }
        return dataModel.finalWidth
    }
    
    func getAttributedString(type: ModeDisplay) -> NSMutableAttributedString {
        let atts: NSMutableAttributedString =
            NSMutableAttributedString(string: type.name + " Cell",
                                      attributes: getConvenienceAttributes(color: .black,
                                                                           font: UIFont.systemFont(ofSize: 21, weight: .bold)))
        
        let thumbnailAtt: NSAttributedString = NSAttributedString(
            string: "\nThumbnail Size: \(type.nameThumbnail)",
            attributes: getConvenienceAttributes(color: .black,
                                                 font: .systemFont(ofSize: 17,
                                                                   weight: .bold)))
        let layoutAtt: NSAttributedString = NSAttributedString(
            string: "\nLayout:\n \t+\(type.nameLayout)",
            attributes: getConvenienceAttributes(color: .black,
                                                 font: .systemFont(ofSize: 14,
                                                                   weight: .medium)))
        
        atts.append(thumbnailAtt)
        atts.append(layoutAtt)
        return atts
    }
    
    func getConvenienceAttributes(color: UIColor, font: UIFont) -> [NSAttributedString.Key: Any] {
        [NSAttributedString.Key.font: font,
         NSAttributedString.Key.foregroundColor: color]
    }
    
}
