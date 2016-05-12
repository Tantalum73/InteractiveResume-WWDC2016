//
//  SelectableView.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 16.09.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit

/// UIView subclass that supports user interaction by tapping on it. Then it highlights itself using an overlay (if set so) and a transformation (shrink).
class SelectableView: UIView {
    
        /// A subview that should be highlighted, if appropriate. If you do not set a viewToBeHighlighted, self will be used instead.
    weak var viewToBeHighlighted : UIView?
    
    private var highlightOverlayView: UIView!
    
        /// Boolean that reflects state of the view.
    var highlighted : Bool = false {
        didSet {
            updateHighlight()
        }
    }
        /// Boolean that specifies if an overlay should be added. If not, only a transformation will be applied.
    var shouldAddOverlay = true {
        didSet {
            updateHighlight()
        }
    }
    
    private func updateHighlight() {
        let viewToHighlight = viewToBeHighlighted ?? self

        if highlighted {
            if shouldAddOverlay {
                highlightOverlayView = UIView(frame: viewToHighlight.frame)
                highlightOverlayView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
                
                highlightOverlayView.translatesAutoresizingMaskIntoConstraints = false
                
                highlightOverlayView.layer.cornerRadius = viewToHighlight.layer.cornerRadius
                
                viewToHighlight.addSubview(highlightOverlayView)
                let views = ["highlightOverlayView":highlightOverlayView]
                
                addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[highlightOverlayView]-0-|", options: [], metrics: nil, views: views))
                addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[highlightOverlayView]-0-|", options: [], metrics: nil, views: views))
            }
            
            
            UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
                
                viewToHighlight.transform = CGAffineTransformMakeScale(0.85, 0.85)
                
                
                }, completion: { (finished) -> Void in
                    
            })
        }
        else {
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 2, options: [], animations: { () -> Void in
                
                self.highlightOverlayView?.alpha = 0
                viewToHighlight.transform = CGAffineTransformIdentity
                
                }, completion: { (finished) -> Void in
                    
                    self.highlightOverlayView?.removeFromSuperview()
                    
            })
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        highlighted = true
        super.touchesBegan(touches, withEvent: event)
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        highlighted = false
        super.touchesEnded(touches, withEvent: event)
    }
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        highlighted = false
        super.touchesCancelled(touches, withEvent: event)
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
    }

}
