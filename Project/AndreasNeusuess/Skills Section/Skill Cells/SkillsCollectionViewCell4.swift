//
//  SkillsCollectionViewCell4.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 12.09.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit

/// SkillsCollectionViewCell used in SkillsPresentationViewController.
final class SkillsCollectionViewCell4: SkillsCollectionViewCell {
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.cellContainerView = containerView
        }
    }
    @IBOutlet weak var outlinedLabelView: OutlinedLabelView!  {
        didSet {
            outlinedLabelView.pathOfLabel = PathStore.webdesignPath.CGPath
            outlinedLabelView.shouldBeCentered = false
            outlinedLabelView.strokeColor = UIColor.whiteColor()
            self.headerLabelView = outlinedLabelView
        }
    }
    
    @IBOutlet weak var clubNewsTeaserImage: UIImageView! {
        didSet {
            clubNewsTeaserImage.tag = 0
        }
    }
    @IBOutlet weak var clubNewsAdminTeaserImage: UIImageView! {
        didSet {
            clubNewsAdminTeaserImage.tag = 1
        }
    }
    @IBOutlet weak var blogTeaserImage: UIImageView! {
        didSet {
            blogTeaserImage.tag = 2
        }
    }
    @IBOutlet weak var tourTimeTeaserImage: UIImageView! {
        didSet {
            tourTimeTeaserImage.tag = 3
        }
    }
    
    @IBOutlet weak var clubNewsOverlayEffectView: UIVisualEffectView! {
        didSet {
            styleOverlayEffectView(clubNewsOverlayEffectView)
        }
    }
    
    @IBOutlet weak var clubNewsAdminPanelOverlayEffectView: UIVisualEffectView! {
        didSet {
            styleOverlayEffectView(clubNewsAdminPanelOverlayEffectView)
        }
    }
    @IBOutlet weak var BlogOverlayEffectView: UIVisualEffectView! {
        didSet {
            styleOverlayEffectView(BlogOverlayEffectView)
        }
    }
    @IBOutlet weak var tourTimeOverlayEffectView: UIVisualEffectView! {
        didSet {
            styleOverlayEffectView(tourTimeOverlayEffectView)
        }
    }
    
    
    //FIXME: Poor design and strong coupling of this cell, the ViewController, the GestureRecognizers and the views they are attached to.                                                       (Array of GestureRecognizers, those GestureRecognizers and the view that they are applied to – had to do it this way because a GestureRecognizer can only have one view 😒
    
        /// Array that holds UITapGestureRecognizer that are later created and attached to the ImageViews.
    private var tapGestureRecognizers = [UITapGestureRecognizer]()
    
    /**
     Function that inits and attaches UITapGestureRecognizer to the imageViews. Their actions will be handled in the calling code, meaning the ViewController. In this way, the cell is not responsible for handling actions but has to add UITapGestureRecognizer to its views.
     Call this method when the cell is about to become visible.
     
     - parameter target: Target of the created UITapGestureRecognizer, should be the ViewController.
     - parameter action: Action of the created UITapGestureRecognizer.
     */
    func addGestureRecognizerToTeaserImagesWithTarget(target: AnyObject?, action: Selector) {
        tapGestureRecognizers.removeAll()
        
        let gr1 = UITapGestureRecognizer(target: target, action: action)
        clubNewsTeaserImage.addGestureRecognizer(gr1)
        
        let gr2 = UITapGestureRecognizer(target: target, action: action)
        clubNewsAdminTeaserImage.addGestureRecognizer(gr2)
        
        let gr3 = UITapGestureRecognizer(target: target, action: action)
        blogTeaserImage.addGestureRecognizer(gr3)
        
        let gr4 = UITapGestureRecognizer(target: target, action: action)
        tourTimeTeaserImage.addGestureRecognizer(gr4)
        
        tapGestureRecognizers = [gr1, gr2, gr3, gr4]
    }
    
    /**
     Function that removes the UITapGestureRecognizers from the ImageViews. Use this method to clean things up after the cell became invisible.
     */
    func removeGestureRecognizerFromTeaserImage() {
        clubNewsTeaserImage.removeGestureRecognizer(tapGestureRecognizers[0])
        clubNewsAdminTeaserImage.removeGestureRecognizer(tapGestureRecognizers[1])
        blogTeaserImage.removeGestureRecognizer(tapGestureRecognizers[2])
        tourTimeTeaserImage.removeGestureRecognizer(tapGestureRecognizers[3])
    }
    
    
    private func styleOverlayEffectView(view: UIVisualEffectView) {
        view.layer.cornerRadius = 7
        view.layer.borderColor = UIColor.blackColor().colorWithAlphaComponent(0.4).CGColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
    }
}
