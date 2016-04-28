//
//  SkillsCollectionViewCell5.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 22.09.15.
//  Copyright © 2015 Anerma. All rights reserved.
//

import UIKit

/// SkillsCollectionViewCell used in SkillsPresentationViewController.
final class SkillsCollectionViewCell5: SkillsCollectionViewCell {

    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.cellContainerView = containerView
        }
    }
    @IBOutlet weak var outlinedLabelView: OutlinedLabelView!  {
        didSet {
            outlinedLabelView.pathOfLabel = PathStore.nodeJSPath.CGPath
            outlinedLabelView.shouldBeCentered = false
            outlinedLabelView.strokeColor = UIColor.colorFromHex(0x78B743)
            self.headerLabelView = outlinedLabelView
        }
    }
}
