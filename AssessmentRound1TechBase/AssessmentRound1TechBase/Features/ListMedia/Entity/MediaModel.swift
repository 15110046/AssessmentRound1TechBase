//
//  MediaModel.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 28/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import SwiftyJSON

enum MediaState {
    case new, downloaded, filtered, failed
}

class MediaModel: BaseModel {
    
    private var author: String?
    private var width: Double?
    private var height: Double?
    private var url: String?
    private var download_url: String?
    
    private var state = MediaState.new
    private var image: UIImage = Constants.Image.Default

    func getStringURLMedia() -> String? {
        return download_url
    }
    
    func getNameAuthor() -> String? {
        return author
    }
    
    func getNameSize() -> String {
        return "Size: \(Int(height ?? 0))x\(Int(width ?? 0))"
    }
    
    func getImage() -> UIImage {
        return image
    }
    
    func getStateImage() -> MediaState {
        return state
    }
    
    func setImage(_ image: UIImage) {
        self.image = image
    }
    
    func setStateImage(_ state: MediaState) {
        self.state = state
    }
    
    override init(json: JSON) {
        super.init()
        self.id = json["id"].int
        self.author = json["author"].string
        self.width = json["width"].double
        self.height = json["height"].double
        self.url = json["url"].string
        self.download_url = json["download_url"].string
    }
    
}
