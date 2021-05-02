//
//  Constants.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 28/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

public struct Constants {
    
    public struct Image {
        public static let Default: UIImage = UIImage(named: "image_default") ?? UIImage()
    }
    
    public struct Cells {
        public static let NoteCollectionViewCell: String = "NoteCollectionViewCell"
        public static let MediaVerticalCollectionViewCell: String = "MediaVerticalCollectionViewCell"
        public static let MediaHorizontalCollectionViewCell: String = "MediaHorizontalCollectionViewCell"

    }
    public static let LimitItemInBlock: Int = 100
    public static let NotifiNameDefault: String = "Thông báo"
    public static let ErrorNetwork: String = "Vui lòng xem lại kết nối mạng"
}
