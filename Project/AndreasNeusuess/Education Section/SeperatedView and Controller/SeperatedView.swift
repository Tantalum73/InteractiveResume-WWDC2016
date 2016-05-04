//
//  NextUpTableViewHeaderView.swift
//  ClubNews
//
//  Created by Andreas Neusüß on 13.03.15.
//  Copyright (c) 2015 Anerma. All rights reserved.
//

import UIKit

/// A UIView subclass that shows a right and a left part in different colors. The size of (and thereby the fraction) can be controlled by setting the 'progress' value. Also has a label to display a title.   Defined in .xib file.
final class SeperatedView: UIView {

    
    @IBOutlet weak var leftPart: UIView!
    @IBOutlet weak var rightPart: UIView!
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var widthOfLeftView: NSLayoutConstraint!
    
        /// Color of its right part.
    var colorOfRightPart : UIColor? {
        didSet {
            setNeedsLayout()
        }
    }
        /// Color of its left part.
    var colorOfLeftPart : UIColor? {
        didSet {
            setNeedsLayout()
        }
    }
        /// Title of the view.
    var title : String? {
        didSet {
            setNeedsLayout()
        }
    }

        /// Progress, specifying the fraction and thereby the size of the left / right view.
    var progress : Double = 1.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //self.addSubview(NSBundle.mainBundle()..first as! SeperatedTableViewHeaderView)
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.colorFromHex(0xAEAAAA).CGColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        headerLabel.text = title
        
        guard leftPart != nil && rightPart != nil && visualEffectView != nil else{return}
        leftPart.backgroundColor = colorOfLeftPart
        rightPart.backgroundColor = colorOfRightPart
        
        let newWidthOfLeftView = frame.width * CGFloat(progress)
        widthOfLeftView?.constant = newWidthOfLeftView
        setNeedsUpdateConstraints()
    }

}
