//
//  SkillsCollectionViewCell2.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 12.09.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit

/// SkillsCollectionViewCell used in SkillsPresentationViewController.
final class SkillsCollectionViewCell2: SkillsCollectionViewCell {
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.cellContainerView = containerView
        }
    }
    
    @IBOutlet weak var outlinedLabelView: OutlinedLabelView! {
        didSet {
            outlinedLabelView.pathOfLabel = PathStore.javaPath.CGPath
            outlinedLabelView.shouldBeCentered = false
            outlinedLabelView.strokeColor = UIColor.whiteColor()
            self.headerLabelView = outlinedLabelView
        }
    }
}
