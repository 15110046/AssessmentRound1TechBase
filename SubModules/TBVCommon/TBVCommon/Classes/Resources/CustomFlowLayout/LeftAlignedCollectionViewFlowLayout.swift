//
//  LeftAlignedCollectionViewFlowLayout.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 29/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

public class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    public init(minimumLineSpacing: CGFloat, minimumInteritemSpacing: CGFloat) {
        super.init()
        self.minimumLineSpacing = minimumLineSpacing
        self.minimumInteritemSpacing = minimumInteritemSpacing
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}
