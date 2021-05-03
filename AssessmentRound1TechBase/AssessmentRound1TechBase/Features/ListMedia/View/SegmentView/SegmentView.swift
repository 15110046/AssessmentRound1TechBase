//
//  SegmentView.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 30/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

protocol SegmentViewDelegate: class {
    func segmentViewchangeMode(at mode: ModeDisplay)
}

class SegmentView: BaseView {
    
    @IBOutlet private weak var segmentView: UISegmentedControl?
    
    weak var delegate: SegmentViewDelegate?
    
    @IBAction private func changeValue(_ sender: UISegmentedControl) {
        guard let nameSegmentSelected = segmentView?.titleForSegment(at: sender.selectedSegmentIndex) else { return  }
        delegate?.segmentViewchangeMode(at: ModeDisplay(string: nameSegmentSelected))
    }
    
    func getSegmentView() -> UISegmentedControl? {
        return segmentView
    }
    
    func configSegment(items: [ModeDisplay], selectedMode: ModeDisplay) {
        if !checkValid(items: items, selectedMode: selectedMode) {
            return
        }
        
        segmentView?.removeAllSegments()
        var indexSelected: Int = 0
        items.enumerated().forEach { [weak self] (index, value) in
            if value == selectedMode {
                indexSelected = index
            }
            self?.segmentView?.insertSegment(withTitle: value.name, at: index, animated: false)
        }
        segmentView?.selectedSegmentIndex = indexSelected
    }
    
    func checkValid(items: [ModeDisplay], selectedMode: ModeDisplay) -> Bool {
        guard !items.isEmpty,
              items.contains(selectedMode) else { return false }
        return true
    }

}
