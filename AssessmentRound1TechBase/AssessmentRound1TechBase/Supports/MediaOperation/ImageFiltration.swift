//
//  ImageFiltration.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 02/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import Foundation

class ImageFiltration: Operation {
    let media: MediaModel
    
    init(_ media: MediaModel) {
        self.media = media
    }
    
    override func main () {
        if isCancelled { return }
        guard self.media.getStateImage() == .downloaded else { return }

        if let filteredImage = resizeImage(image: media.getImage(),
                                           targetSize: CGSize(width: media.finalWidth, height: media.finalHeight)) {
            media.setImage(filteredImage)
            media.setStateImage(.filtered)
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
