//
//  NoteCollectionViewCell.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 29/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

class NoteCollectionViewCell: BaseCollectionViewCell<NoteCollectionViewCellPresenter> {

    @IBOutlet private weak var noteLabel: UILabel?
    
    func getNoteLabel() -> UILabel? {
        return noteLabel
    }
    
    override func bindCell(presenter: NoteCollectionViewCellPresenter) {
        super.bindCell(presenter: presenter)
        noteLabel?.attributedText = presenter.getAttributedString(type: presenter.modeDisplay)
    }
    
}
