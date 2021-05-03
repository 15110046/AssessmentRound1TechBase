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
        case .regular:
            return "MediaVerticalCollectionViewCell"
        case .compact:
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
            case .regular:
                let constHeightCellRegular: CGFloat = 120
                dataModel.finalHeight = constHeightCellRegular
            case .compact:
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
    
    func getImage(size: CGSize) -> UIImage? {
        switch dataModel.getStateImage() {
        case .filtered: return dataModel.getImage()
        case .downloaded:
            let image = dataModel.getImage()
            if image.size.width*image.size.height <= 1.5*(size.width*size.height) {
                return image
            } else {
                return Constants.Image.Default
            }
        case .new, .failed: return Constants.Image.Default
        }
    }
    
}
