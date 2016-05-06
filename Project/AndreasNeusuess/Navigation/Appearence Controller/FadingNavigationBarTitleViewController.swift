//
//  FadingNavigationBarTitleViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 01.09.15.
//  Copyright © 2015 Anerma. All rights reserved.
//

import UIKit

/// FadingNavigationBarTitleViewController manages handling of a UIView that becomes titleView of an NavigationBar as the user scrolls. At first, the view is inside of the ScrollView but if the user scrolls down, it is added to the NavigationBar and acts as its title.
final class FadingNavigationBarTitleViewController: NSObject {
    private weak var navigationController : UINavigationController!
    private weak var viewThatBecomesTitleView: UILabel!
    
    private var didSetTitleView = false
    private var titleView : UIView!
    private var initialYPosition : CGFloat?
    private let spaceToTopWhenTopViewIsShrinked : CGFloat = 18

    
    /**
     Init with required properties.
     
     - parameter inViewController:        ViewController in which the view is embedded that shall become a titleView.
     - parameter inNavigationController:   NavigationController that should be involved in this effect.
     - parameter viewThatBecomesTitleView: View that will become titleView and is scaled as the user scrolls.
     
     - returns: Instance of FadingNavigationBarTitleViewController.
     */
    init(inViewController: UIViewController, inNavigationController: UINavigationController, viewThatBecomesTitleView: UILabel) {
        self.navigationController = inNavigationController
        self.viewThatBecomesTitleView = viewThatBecomesTitleView
        super.init()
        
        prepareTitleLabel(inViewController)
    }
    
    This line will prevent compiling.
    
    Please note the copyright and be so kind to play along.
    
    If you would like to use parts of the app, please contact me :)
    
    
    /**
     Setting up the titleLabel: the label that will be displayed in the NavigationBar as the scrollView is scrolled down.
     
     - parameter forViewController: ViewController in which the view is placed.
     */
    func prepareTitleLabel(forViewController: UIViewController) {
        titleView = copiedLabelFromLabel(viewThatBecomesTitleView)
        
        
        forViewController.navigationItem.titleView = titleView
        titleView.alpha = 0
        
    }
    
    private func copiedLabelFromLabel(oldLabel: UILabel) ->UILabel {
        //performing a deep copy by archiving and unarchiving the label. Not the most decent way but ensures that every property is copied.
        let data = NSKeyedArchiver.archivedDataWithRootObject(oldLabel)
        
        let newLabel = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! UILabel
//        let newLabel = UILabel()
//        newLabel.text = oldLabel.text
//        newLabel.font = oldLabel.font
//        newLabel.textColor = oldLabel.textColor
//        newLabel.frame = oldLabel.frame
//        newLabel.preferredMaxLayoutWidth = oldLabel.preferredMaxLayoutWidth
//        newLabel.minimumScaleFactor = oldLabel.minimumScaleFactor
//        newLabel.textAlignment = oldLabel.textAlignment
//        newLabel.clipsToBounds = oldLabel.clipsToBounds
//        newLabel.contentScaleFactor = oldLabel.contentScaleFactor
        
        return newLabel
    }

/**
     Call this method on scrollViewDidScroll to update the titleView of the NavigationBar.
     
     - parameter scrollView: The UIScrollView that was scroller. It holds the view to be transitioned into the NavigationBar.
     */
    func updateTitleView(scrollView: UIScrollView) {

//                    print("offset: \(scrollView.contentOffset.y)")
        
        let navBar = navigationController!.navigationBar
        
        let globalOriginOfLabel = viewThatBecomesTitleView.superview!.superview!.convertPoint(viewThatBecomesTitleView.frame.origin, toView: nil).y
        
//        print("GlobalOrigin: \(globalOriginOfLabel)")
        
        let shouldScrollWithScrollView = scrollView.contentOffset.y >= 0
        let notYetScrolledToTop = globalOriginOfLabel > spaceToTopWhenTopViewIsShrinked
        
        if initialYPosition == nil {
            initialYPosition = globalOriginOfLabel
        }
        

        if shouldScrollWithScrollView && notYetScrolledToTop {
            
            
            if !didSetTitleView {
//                                    print("DID add to NavBar")
                viewThatBecomesTitleView.alpha = 0
                
                titleView.alpha = 1
                
                didSetTitleView = true
                
            }
            titleView.center.x = viewThatBecomesTitleView.center.x
            titleView.center.y = -scrollView.contentOffset.y + titleView.frame.size.height + 3.5
            
        }
        else if !shouldScrollWithScrollView && notYetScrolledToTop && didSetTitleView {
            //adding label back to the original view again
            titleView.alpha = 0
            viewThatBecomesTitleView.alpha = 1
            didSetTitleView = false
//                            print("DID remove from NavBar")
            
        }
        else {
            //setting the label to its upper bound to catch the case in which the user has scrolled too fast for the scrollView to keep updating
            titleView.center.x = titleView.center.x
            titleView.center.y = navBar.frame.size.height / 2.0
            
//            print("final set")

        }
        
        //Scaling the label down by the proportion, the scrolling is done...
        //Allows big size when not scrolled and small size when the label is in the NavigationBar.
        let progress = progressOfScrollToTopForGlobalOriginY(globalOriginOfLabel)
//        print("Progress: \(progress)")
        
        scaleView(titleView, progress: progress)

        
        
    }
    
    private func progressOfScrollToTopForGlobalOriginY(origin: CGFloat) -> CGFloat {
        //progress with padding so the user can scroll a bi before the zoom starts.
        var progress = origin + 2 * spaceToTopWhenTopViewIsShrinked
        
        progress = progress / initialYPosition!
        
        progress = 1 - progress
        

        return progress < 0 ? 0 : progress
    }
    /**
     Helper method that applies transformation to the given view based on the scroll views position represented in the progress argument.
     
     - parameter view:     View that shall be shrinked or grown concerning progress.
     - parameter progress: Progress of the scroll. 0 when started, 1 when finished.
     */
    private func scaleView(view: UIView, progress: CGFloat) {
        view.transform = transformForProgress(progress)
    }
    

    /**
     Helper method that calculates an applicable CGAffineTransform based on a given progress.
     
     - parameter progress: Progress of the scroll. 0 when started, 1 when finished.
     
     - returns: CGAffineTransform that can be applied to views that play along with the scroll.
     */
    private func transformForProgress(progress: CGFloat) -> CGAffineTransform {
        if progress == 0 {
            return CGAffineTransformIdentity
        }
        
        let normalizedScale = max((1-progress), 0.7)
        
        let transform = CGAffineTransformMakeScale(normalizedScale, normalizedScale)
        return transform
    }
    
    
    private func fontSizeForProgress(progress: CGFloat, initialFontSize: CGFloat) -> CGFloat {
        if progress == 0 {
            return initialFontSize
        }
        
        let normalizedScale = max((1-progress), 0.7)
        let scaledSize = normalizedScale * initialFontSize
        
        return scaledSize
    }
}
