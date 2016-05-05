//
//  InitialViewBackgroundView.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 29.08.15.
//  Copyright (c) 2015 Anerma. All rights reserved.
//

import UIKit

@IBDesignable
/// Background view of the initial view. It contains the 'bubbles' (round views) that move around. Also has an method to animate from gray to colored state.
final class InitialViewBackgroundView: UIView {

    
    private var cicleViews : [UIView]?
    private var grayOverlayViews : [UIView]?
    private var possibleColors : [UIColor] = [UIColor.colorFromHex(0x50E3C2, alpha: 0.8), UIColor.colorFromHex(0xFF9000, alpha: 0.9), UIColor.colorFromHex(0xF8E71C, alpha: 0.9), UIColor.colorFromHex(0xFE8C8C, alpha: 0.7), UIColor.colorFromHex(0x7ED321, alpha: 0.55), UIColor.colorFromHex(0x4A90E2, alpha: 0.6)]
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    override func layoutSubviews() {
        if cicleViews == nil {
            setUp()
        }
    }
    override func prepareForInterfaceBuilder() {
        setUp()
    }
    
    /**
     Setting up the round views.
     */
    func setUp() {
        cicleViews = [UIView]()
        grayOverlayViews = [UIView]()
        
        for i in 0..<possibleColors.count {
            let radius = randomFloatBetweenNumbers(33.0, secondNum: 200)
            let position = randomPositionInRect(bounds)
            
            let newView = UIView(frame: CGRectMake(position.x, position.y, radius, radius))
            newView.layer.cornerRadius = newView.bounds.width / 2
            newView.clipsToBounds = true
            newView.backgroundColor = possibleColors[i]
            
            let grayOverlayView = UIView(frame: newView.bounds)
            grayOverlayView.backgroundColor = UIColor.colorFromHex(0xC7B3B3, alpha: 0.9)
            
            newView.addSubview(grayOverlayView)
            grayOverlayViews!.append(grayOverlayView)
            
            addSubview(newView)
            cicleViews!.append(newView)
        }
//        addImageView()
        addAnimations()
        addBlurrView()
        
    }
    
    /**
     Method used for coloring the initial gray views using an animation.
     
     - parameter duration: Duration of the animation.
     */
    func bringInTheColorUsingAnimationWithDuration(duration: Double) {
        guard let grayViews = grayOverlayViews else {return}
        
        UIView.animateWithDuration(duration, delay: 0, options: [], animations: { () -> Void in
            
            for view in grayViews {
                view.alpha = 0
            }
            
            }) { (_) -> Void in
                for view in grayViews {
                    view.removeFromSuperview()
                }
                
        }
    }
    
    private func addBlurrView() {
        let visualBlurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        let views = ["visualBlurEffectView" : visualBlurEffectView]
        
        visualBlurEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualBlurEffectView.backgroundColor = UIColor.clearColor()
        addSubview(visualBlurEffectView)
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[visualBlurEffectView]-0-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[visualBlurEffectView]-0-|", options: [], metrics: nil, views: views))
    }

    private func addAnimations() {
        
        
        if let theViews = cicleViews {
            for theView in theViews {
                theView.layer.removeAllAnimations()
            }
            
            
            UIView.animateKeyframesWithDuration(8.0, delay: 0, options: [UIViewKeyframeAnimationOptions.CalculationModePaced , .Repeat , .BeginFromCurrentState, .Autoreverse], animations: { () -> Void in
                
                
                for theView in theViews {
                    UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1, animations: { () -> Void in
                        let newPosition = self.randomPositionInRect(self.bounds)
                        theView.center = newPosition
                    })
                }
                
                }) { (finished) -> Void in
                    
            }
        }
    }
    
    private func randomFloatBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    private func randomPositionInRect(rect: CGRect) -> CGPoint {
        return CGPoint(x: randomFloatBetweenNumbers(rect.origin.x, secondNum: rect.width), y: randomFloatBetweenNumbers(rect.origin.y, secondNum: rect.height))
    }

}
