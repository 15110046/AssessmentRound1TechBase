//
//  BottomLoadingView.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 30/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

class BottomLoadingView: BaseView {
    
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView?

    func setHidden(_ isHidden: Bool) {
        self.isHidden = isHidden
        if isHidden {
            indicatorView?.stopAnimating()
        } else {
            indicatorView?.startAnimating()
        }
    }
    
    func getIndicatorView() -> UIActivityIndicatorView? {
        return indicatorView
    }
    
}
