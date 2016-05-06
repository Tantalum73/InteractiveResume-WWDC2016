//
//  ParallaxImageContainerView.swift
//  ClubNews
//
//  Created by Andreas Neusüß on 01.08.15.
//  Copyright (c) 2015 Anerma. All rights reserved.
//

import UIKit

@IBDesignable
/// ContainerView that will apply a parallax effect to its parallaxImageView property (a subview). The effect must be updated in every UIScrollViewDidScroll event in order to achieve desired effect. I also recommend to update it in the ViewControllers viewDidLayoutSubviews() method to avoid jumps after ViewDidAppear().
final class ParallaxImageContainerView: UIView {
    
    
    @IBOutlet weak var parallaxImageView: UIImageView?
    
    /**The ratio of which the parallax imageView will be
    slowed down in relation to the users scroll speed.
    If this value is 1, the imageView will position itself by the speed of scrolling.
    However, a value about 0.2 is recommended.
    */
    @IBInspectable
    var parallaxScrollRatio : CGFloat = 0.2

        /// Flag that indicates if the view is expanded.
    var isExpanded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
    }

    /**
     Call this method to update the effect regarding the views current position. I also recommend to update it in the ViewControllers viewDidLayoutSubviews() method to avoid jumps after ViewDidAppear().
     */
    func updatePosition() {
        let globalFrame = self.convertRect(bounds, toView: nil)
        
        
        guard let imageView = parallaxImageView else {return }
        var offsetForImageView = globalFrame.origin.y * -parallaxScrollRatio + 10.0
        
        if offsetForImageView > 0 {
            //we have crossed the upper bound of the container frame, will position it at the top.
            offsetForImageView = 0
            
            
        }
        else if  (offsetForImageView + imageView.frame.size.height) < frame.size.height {
            //we have crossed the lower bound of the container frame, will position it at the bottom.
            offsetForImageView = frame.size.height - imageView.frame.size.height
            
        }
        imageView.frame.origin.y = offsetForImageView
        
        
        
    }
    
}
