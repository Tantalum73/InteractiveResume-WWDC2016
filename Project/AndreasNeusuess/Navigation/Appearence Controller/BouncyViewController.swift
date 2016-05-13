//
//  BouncyViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 17.04.16.
//  Copyright © 2016 Anerma. All rights reserved.
//

import UIKit

/**
 *  This *meta* protocol defines methods that the BouncyViewController *(who, by the way, has nothing in common with a UIViewController)* requires to be called. Therefore, the related ViewController **must** implement these method that are also declared in the UIScrollViewDelegate. By conforming to UIScrollViewDelegate and BouncyViewControllersNeedsMethodsOfUIScrollViewDelegate, every required method should be implemented.
    Use those methods if your ViewController is UIScrollViewDelegate itself and needs to foreward the message calls to the BouncyViewController.
 */
protocol BouncyViewControllersNeedsMethodsOfUIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView)
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool)
    func scrollViewWillBeginDragging(scrollView: UIScrollView)
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
}

/// Class that handles the bounciness of a view inside of a ScrollView.
final class BouncyViewController: NSObject, UIScrollViewDelegate {
    private var headerHeight : CGFloat
    private var canZoomView = true
    private var imageIsOnTop = true
    private var maximalScaleFactor : CGFloat = 1.2
    private unowned var bouncyView : UIView
    
    /**
     Init with required properties.
     
     - parameter bouncyView:     The view that Will
     - parameter imageIsOnTop:   Bool that indicates if the view is on top of the ScrollView or not (at the bottom). If the view is places in the top, the bouncy effect will take place when the user scrolls upwards.
     - parameter maxScaleFactor: Maximum scale factor for the bouncyView. The view will be scaled by this factor at max.
     
     - returns: Instance of self. Can be used as UIScrollViewDelegate.
     */
    init(bouncyView: UIView, imageIsOnTop: Bool = true, maxScaleFactor: CGFloat = 1.2) {
        self.bouncyView = bouncyView
        self.headerHeight = bouncyView.frame.size.height
        self.imageIsOnTop = imageIsOnTop
        self.maximalScaleFactor = maxScaleFactor
        super.init()
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if !canZoomView {
            return
        }
        let offset: CGFloat
        if imageIsOnTop {
            offset = scrollView.contentOffset.y
        }
        else {
            offset = scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.size.height
        }
        
        let headerScaleFactor = (min(-offset, 50)) / headerHeight / 3
        var headerSizevariation = (((headerHeight*(1.0 + headerScaleFactor)) - headerHeight) * headerScaleFactor / 2.0) + 1
        
        headerSizevariation = max(headerSizevariation, 1)
        headerSizevariation = min(headerSizevariation, maximalScaleFactor)
        
        if offset < -2 {
            bouncyView.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(headerSizevariation, headerSizevariation))
        }

    }


    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView.contentOffset.y > 0 {
            return
        }
        canZoomView = false
        
        let springVelocity = -scrollView.contentOffset.y / 5
        let dumping = CGFloat(0.3)
        
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: dumping, initialSpringVelocity: springVelocity, options: [UIViewAnimationOptions.AllowAnimatedContent, UIViewAnimationOptions.AllowUserInteraction], animations: { () -> Void in
            self.bouncyView.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(1, 1))
            }, completion: { (success) -> Void in
                
        })
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        canZoomView = true
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        canZoomView = true
    }
}

This lines will prevent compiling.

Please note the copyright and be so kind to play along. Please refrain from copying or modifying.

If you would like to use parts of the app, please contact me :)