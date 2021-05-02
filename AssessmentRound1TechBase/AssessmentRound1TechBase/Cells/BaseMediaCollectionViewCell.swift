//
//  BaseMediaCollectionViewCell.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 29/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import HNImageView

class BaseMediaCollectionViewCell: BaseCollectionViewCell<MediaCollectionViewCellPresenter> {
    
    @IBOutlet private weak var mediaImageView:  HNImageView?
    @IBOutlet private weak var authorLabel:     UILabel?
    @IBOutlet private weak var sizeLabel:       UILabel?
    @IBOutlet private weak var containerView:   UIView?
    
    func getImageView() -> UIImageView? {
        return mediaImageView
    }
    
    func getAuthorLabel() -> UILabel? {
        return authorLabel
    }
    
    func getSizeLabel() -> UILabel? {
        return sizeLabel
    }
    
    func getContainerView() -> UIView? {
        return containerView
    }
    
    override func bindCell(presenter: MediaCollectionViewCellPresenter) {
        super.bindCell(presenter: presenter)
        authorLabel?.text                = presenter.dataModel.getNameAuthor()
        sizeLabel?.text                  = presenter.dataModel.getNameSize()
        containerView?.layer.borderWidth = 1
        containerView?.layer.borderColor = UIColor.gray.cgColor
        
        let image = presenter.dataModel.getImage()
        
        if presenter.dataModel.getStateImage() == .filtered {
            mediaImageView?.image = image
        } else {
            if image.size.width*image.size.height <= 1.5*(mediaImageView?.frame.width ?? 0)*(mediaImageView?.frame.height ?? 0) {
                mediaImageView?.image = image
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mediaImageView?.config(HNImageViewConfigure(backgroundColor: .clear,
                                                    durationDismissZoom: 0.2,
                                                    maxZoom: 4,
                                                    minZoom: 0.8,
                                                    vibrateWhenStop: false,
                                                    autoStopWhenZoomMin: false,
                                                    isUpdateAlphaWhenHandle: true))
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mediaImageView?.image = nil
        authorLabel?.text = nil
        sizeLabel?.text = nil
    }
}
