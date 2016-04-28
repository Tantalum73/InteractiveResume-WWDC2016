//
//  SkillsCollectionViewCell.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 15.09.15.
//  Copyright © 2015 Anerma. All rights reserved.
//

import UIKit

/// UICollectionViewCell used in SkillsPresentationViewController. This class defines a subset of methods that every skill-cell shares.
class SkillsCollectionViewCell: UICollectionViewCell {
        /// A OutlinedLabelView that shows the title of the cell.
    var headerLabelView : OutlinedLabelView?
    
        /// Container UIView that is customized to be card-shapened (round corners, borderColor, ...)
    var cellContainerView : UIView? {
        didSet {
            cellContainerView?.layer.cornerRadius = 20
            cellContainerView?.clipsToBounds = true
            cellContainerView?.layer.borderColor = UIColor.colorFromHex(0x979797).CGColor
            cellContainerView?.layer.borderWidth = 1
        }
    }
    
    /**
     Method to update the cell accordingly to an scrollViewDidScroll event.
     
     - parameter scrollView: The scrollView that has scrolled.
     */
    func scrollViewDidScroll(scrollView: UIScrollView) {
        guard let outlinedHeader = headerLabelView, let superview = superview else{return}
        
        let origin = superview.convertPoint(frame.origin, toView: nil)
        let widthOfScreen = UIScreen.mainScreen().bounds.width
        
        let progressOfSwiping = 1 - fabs(origin.x / widthOfScreen)
        
        outlinedHeader.progressOfStroke = progressOfSwiping
    }
    
    
}
