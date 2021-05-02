//
//  MediaCollectionViewCellPresenter.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 02/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

class MediaCollectionViewCellPresenter: BaseCellPresenter {
    
    private(set) var modeDisplay: ModeDisplay
    private(set) var dataModel: MediaModel
    
    override func getCellName() -> String {
        switch modeDisplay {
        case .Regular:
            return "MediaVerticalCollectionViewCell"
        case .Compact:
            return "MediaHorizontalCollectionViewCell"
        }
    }
    
    init(modeDisplay: ModeDisplay, dataModel: MediaModel) {
        self.modeDisplay = modeDisplay
        self.dataModel = dataModel
        super.init()
    }
    
    override func calculateHeightCell(maxWidth: CGFloat) -> CGFloat {
        if dataModel.finalHeight == -1 {
            let constHeightText: CGFloat = 48
            switch modeDisplay {
            case .Regular:
                let constHeightCellRegular: CGFloat = 120
                dataModel.finalHeight = constHeightCellRegular
            case .Compact:
                dataModel.finalHeight = maxWidth/CGFloat(modeDisplay.column) + constHeightText
            }
        }
        return dataModel.finalHeight
    }
    
    override func calculateWidthCell(maxWidth: CGFloat) -> CGFloat {
        if dataModel.finalWidth == -1 {
            switch modeDisplay {
            case .Regular:
                dataModel.finalWidth = (maxWidth)/CGFloat(modeDisplay.column)
            case .Compact:
                dataModel.finalWidth = maxWidth/CGFloat(modeDisplay.column)
            }
        }
        return dataModel.finalWidth
    }
    
    override func getCellHeight(maxWidth: CGFloat) -> CGFloat {
        return calculateHeightCell(maxWidth: maxWidth)
    }
    
    override func getCellWidth(maxWidth: CGFloat) -> CGFloat {
        return calculateWidthCell(maxWidth: maxWidth)
    }
}
