//
//  ListMediaRounter.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 30/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

extension ListMediaViewController: ListMediaRouter {
    
    func showToast(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
    
}
