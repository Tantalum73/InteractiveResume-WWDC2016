//
//  PicturePresentationCollectionViewCell.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 17.09.15.
//  Copyright © 2015 Anerma. All rights reserved.
//

import UIKit

/**
 *  Struct that holds an image and a String? to be passed to the PicturePresentationCollectionViewCell for displaying.
 */
struct PicturePresentationCellData {
        /// Image that should be displayed in the cell.
    let imageName : String
        /// Description text that can be displayed in the cell. If it is nil or empty, no label or VisualEffectView will be presented.
    let description : String?
}

/// UICollectionViewCell that is used in PicturePresentationCollectionViewController to display a given image and its description in a cell. The data is passed using a PicturePresentationCellData object.
final class PicturePresentationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var pictureDescriptionLabel: UILabel!
    @IBOutlet weak var descriptionBackgroundVisualEffectView: UIVisualEffectView! {
        didSet {
            descriptionBackgroundVisualEffectView.layer.cornerRadius = 7
            descriptionBackgroundVisualEffectView.layer.borderColor = UIColor.blackColor().colorWithAlphaComponent(0.4).CGColor
            descriptionBackgroundVisualEffectView.layer.borderWidth = 1
            descriptionBackgroundVisualEffectView.clipsToBounds = true
        }
    }
    
    /**
     Configures the cell by using a given PicturePresentationCellData object.
     
     - parameter data: This struct holds values for the image an description that shall be displayed.
     */
    func configure(data: PicturePresentationCellData) {
        pictureImageView.image = UIImage(named: data.imageName)
        if let text = data.description where !text.isEmpty {
            descriptionBackgroundVisualEffectView.hidden = false
            pictureDescriptionLabel.text = text
        }
        else {
            descriptionBackgroundVisualEffectView.hidden = true
        }
    }
}
