//
//  ImageDownloader.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 02/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import Foundation

class ImageDownloader: Operation {
    
    let media: MediaModel
    
    init(_ media: MediaModel) {
        self.media = media
    }
    
    override func main() {
        log(" =>>>>>>>>> ImageDownloader \(media.getNameAuthor() ?? "")")
        
        if isCancelled { return }
        
        guard let urlImage = URL(string: media.getStringURLMedia() ?? ""),
            let imageData = try? Data(contentsOf: urlImage) else { return }
        
        if isCancelled { return }
        
        if !imageData.isEmpty, let image = UIImage(data: imageData) {
            media.setImage(image)
            media.setStateImage(.downloaded)
        } else {
            media.setStateImage(.failed)
        }
    }
}
