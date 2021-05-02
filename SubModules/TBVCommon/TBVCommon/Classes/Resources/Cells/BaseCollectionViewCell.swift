//
//  BaseCollectionViewCell.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 29/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

public protocol CellPresenterInterface: class {
    func getCellHeight(maxWidth: CGFloat) -> CGFloat
    func getCellWidth(maxWidth: CGFloat) -> CGFloat
    func clearData()
    func getCellName() -> String
    func calculateHeightCell(maxWidth: CGFloat) -> CGFloat
    func calculateWidthCell(maxWidth: CGFloat) -> CGFloat
}

public protocol CellViewInterface: class {
    func loadCell(_ presenter: Any?)
}

open class BaseCellPresenter: BaseModel, CellPresenterInterface {
    
    open func calculateWidthCell(maxWidth: CGFloat) -> CGFloat {
        return 0
    }
    
    open func calculateHeightCell(maxWidth: CGFloat) -> CGFloat {
        return 0
    }
    
    open func getCellHeight(maxWidth: CGFloat) -> CGFloat {
        return calculateHeightCell(maxWidth: maxWidth)
    }
    
    open func getCellWidth(maxWidth: CGFloat) -> CGFloat {
        return calculateWidthCell(maxWidth: maxWidth)
    }
    
    open func clearData() {
        
    }
    
    open func getCellName() -> String {
        return ""
    }
    
    deinit {
        print("======= \(String(describing: self)) cell presenter deinit ====")
    }
}

open class BaseCollectionViewCell<T: CellPresenterInterface>: UICollectionViewCell, CellViewInterface {
    
    public var presenter: T?
    
    open override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    open func bindCell(presenter: T) {
        self.presenter = presenter
    }
    
    open func loadCell(_ presenter: Any?) {
        if let presenter = presenter as? T {
            self.bindCell(presenter: presenter)
        }
    }
}

