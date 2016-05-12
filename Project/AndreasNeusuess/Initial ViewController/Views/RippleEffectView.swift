//
//  RippleEffectView.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 24.12.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit

/// View that draws the ripple effect used to hint the user to their next target. It will animate behind a given view to draw attention to it.
final class RippleEffectView: UIView {
    
        /// View in which the RippleEffectView shall be placed.
    weak var inView: UIView!
        /// View behind which the RippleEffectView shall be placed.
    weak var behindView: UIView!
    
    /**
     Initializer that will create a RippleEffectView instance behind a given view, in a given view.
     
     - parameter behindView: The view that should be highlighted by the RippleEffectView.
     - parameter inView:     The view that holds both the RippleEffectView and the view behind which it will be placed. behindViews superview, basically.
     
     - returns: Instance of RippleEffectView.
     */
    init(behindView: UIView, inView: UIView) {
        self.inView = inView
        self.behindView = behindView
        super.init(frame: CGRectZero)
        
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Setting up the view hirachy and starting animation.
     */
    private func setUp() {
        //stupid hack to insert it at position 1 but doing so using 'insertSubView:belowViewSubview' will add the effect above the desired view cO
        inView.insertSubview(self, atIndex: 1)
//        inView.insertSubview(self, belowSubview: behindView)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.widthAnchor.constraintEqualToAnchor(behindView.widthAnchor, multiplier: 1).active = true
        self.heightAnchor.constraintEqualToAnchor(behindView.heightAnchor, multiplier: 1).active = true
        self.centerXAnchor.constraintEqualToAnchor(behindView.centerXAnchor).active = true
        self.centerYAnchor.constraintEqualToAnchor(behindView.centerYAnchor).active = true
        
        self.backgroundColor = UIColor.clearColor()
        self.alpha = 1
        
        layer.borderWidth = 2
        layer.borderColor = UIColor.colorFromHex(0xADADAD).CGColor
        
        layer.cornerRadius = behindView.layer.cornerRadius
        startAnimating()
    }
    
    /**
     Starts animating the ripple effect.
     */
    func startAnimating() {
        self.transform = CGAffineTransformMakeScale(0.95, 0.95)
        UIView.animateWithDuration(2, delay: 0, options: .Repeat, animations: { () -> Void in
            self.transform = CGAffineTransformScale(self.transform, 1.6, 1.6)
            self.alpha = 0
            
            }) { (_) -> Void in
                
        }
    }
    
    /**
     Removed the RippleEffectView from its superview, animated.
     */
    func remove() {
        UIView.animateWithDuration(0.5, delay: 0, options: [UIViewAnimationOptions.CurveEaseIn], animations: { () -> Void in
            self.alpha = 0
            
            }) { (_) -> Void in
                self.alpha = 1
                self.removeFromSuperview()
        }
    }


}
