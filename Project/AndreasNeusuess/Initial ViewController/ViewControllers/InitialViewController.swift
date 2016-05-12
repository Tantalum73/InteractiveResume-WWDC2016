//
//  InitialViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 27.08.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit

This line will prevent compiling.

Please note the copyright and be so kind to play along.

If you would like to use parts of the app, please contact me :)


/// First viewController of the app. Shows intro animation, center view and initialViews laid out around it. Handles navigation to sections.
final class InitialViewController: UIViewController {
    @IBOutlet weak var backgroundViewWithBubbles: InitialViewBackgroundView!

    @IBOutlet weak var centerView: UIView! {
        didSet {
            centerView.addGestureRecognizer(tapCenterViewGestureRecignizer)
            centerView.layer.borderColor = UIColor.colorFromHex(0xA7A5A5).CGColor//UIColor.grayColor().CGColor
            
            centerView.layer.shadowRadius = 4
            centerView.layer.shadowOpacity = 0
            centerView.layer.shadowOffset = CGSizeMake(3, 5)
            centerView.layer.shadowColor = UIColor.blackColor().CGColor
        }
    }
    @IBOutlet weak var heightOfCenterViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton! {
        didSet {
            if traitCollection.forceTouchCapability == .Available {
                registerForPreviewingWithDelegate(self, sourceView: infoButton)
            }
        }
    }
    
    private lazy var tapCenterViewGestureRecignizer : UITapGestureRecognizer = {
        let gr = UITapGestureRecognizer(target: self, action: #selector(InitialViewController.centerViewTapped(_:)))
        return gr
    }()

    private var rippleBehindCenterView: RippleEffectView!
    private var rippleBehindSectionView: RippleEffectView!
    private var indexOfLastSelectedIndex = 0
    private var didAnimateSectionViews = false
    
    ///The size of the circle when all points are on screen before expansion.
    private var sizeOfSectionCircle : Double {
        
        let number = Double(view.bounds.width) - 2 * Double(self.sizeOfSections)
        return Double(number * self.expansionrate)
    }//= 70
    
    ///Number of displayed sections.
    private let numberOfSections = 7
    ///Distance between two points
    private var agleIncrement : Double {
        let number = M_PI * 2.0 / Double(numberOfSections)
        return Double(number)
    }//M_PI * 2/numberOfSections

    ///Scale of the full circle after all sections have appeared.
    private var expansionrate : Double {
        let rate = view.bounds.size.width <= 320 ? 0.7 : 0.6
        return rate
    }
    ///Size of the sections.
    private let sizeOfSections : CGFloat = 70


    
    private var sectionViews: [InitialViewSectionView] = []
    private var ttiTransitionController : TTITransitionController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        view.tintColor = UIColor.colorFromHex(0xE93000)

        let shadowOffsetsOfCenterView = centerView.layer.shadowOffset
        let shadowOffsetOfCenterViewForMotionEffects = CGSize(width: -(10 + shadowOffsetsOfCenterView.width), height: -(10 + shadowOffsetsOfCenterView.height))
        
        centerView.addMotionEffects(deltaX: -10, deltaY: -10)
        centerView.addMotionEffectsForShadow(height: Double(shadowOffsetOfCenterViewForMotionEffects.height), width: Double(shadowOffsetOfCenterViewForMotionEffects.width))
            
        helloLabel.addMotionEffects(deltaX: -10, deltaY: -10)
        
        if traitCollection.forceTouchCapability == .Available {
            registerForPreviewingWithDelegate(self, sourceView: centerView)
        }
    }

    override func viewDidAppear(animated: Bool) {
        showRippleBehindCenterView()
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func createSectionViews() {
        let bundle = NSBundle.mainBundle()
        for index in 0..<numberOfSections {
            
            if let view = bundle.loadNibNamed("InitialViewSectionView", owner: self, options: nil).first as? InitialViewSectionView {
                
                view.indexOfView = index
                
                view.transform = CGAffineTransformScale(view.transform, 0.5, 0.5)
                view.alpha = 0
                
                view.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(view)
                
                view.center = centerView.center
                
                let verticalToCenter = view.centerYAnchor.constraintEqualToAnchor(centerView.centerYAnchor)
                verticalToCenter.constant = 0
                let horizontalToCenter = view.centerXAnchor.constraintEqualToAnchor(centerView.centerXAnchor)
                horizontalToCenter.constant = 0
                
                view.constraintHorizontalToCenter = horizontalToCenter
                view.constraintVerticalToCenter = verticalToCenter
                
                let tapGR : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InitialViewController.sectionViewPressed(_:)))
                view.addGestureRecognizer(tapGR)
                
                let shadowOffsetOfView = view.layer.shadowOffset
                let shadowOffsetOfViewForMotionEffects = CGSize(width: -(10 + shadowOffsetOfView.width), height: -(10 + shadowOffsetOfView.height))
                
                view.addMotionEffectsForShadow(height: Double(shadowOffsetOfViewForMotionEffects.height), width: Double(shadowOffsetOfViewForMotionEffects.width))
                view.addMotionEffects(deltaX: -15, deltaY: -15)
                
                
                if traitCollection.forceTouchCapability == .Available {
                    registerForPreviewingWithDelegate(self, sourceView: view)
                }
                sectionViews.append(view)
            }
        }
    }
    
    private func openSectionViews() {
        createSectionViews()
        
        for index in 0..<numberOfSections {
            let view = sectionViews[index]
            
            var position = self.centerView.center
            position.x = CGFloat( Double(sizeOfSectionCircle) * sin(Double(index) * self.agleIncrement))
            position.y = CGFloat( Double(sizeOfSectionCircle) * -cos(Double(index) * self.agleIncrement))
            
            view.constraintHorizontalToCenter?.constant = position.x
            view.constraintVerticalToCenter?.constant = position.y
            
            
            UIView.animateWithDuration(1.2, delay: 0.05*Double(index), usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: [UIViewAnimationOptions.AllowAnimatedContent , UIViewAnimationOptions.BeginFromCurrentState], animations: { () -> Void in
                
                view.transform = CGAffineTransformIdentity//CGAffineTransformScale(view.transform, 2.0, 2.0)
                
//                view.center = position
                view.constraintHorizontalToCenter?.active = true
                view.constraintVerticalToCenter?.active = true
                view.layoutIfNeeded()
                
                view.alpha = 1
                
                }, completion: { (finished) -> Void in
                    if index == self.numberOfSections-1 {
                        //next step of animation
                        self.view.layoutIfNeeded()
                    }
            })
        }
    }

    /**
     Method that is called when the center view is tapped.
     Will start animation.
     
     - parameter gestureRecognizer: GestureRecognizer that is responsible for calling this method.
     */
    func centerViewTapped(gestureRecognizer: UITapGestureRecognizer) {
        guard gestureRecognizer.state == UIGestureRecognizerState.Recognized else {return}
        
        //fading out the label and fading out the shadow.
        UIView.animateWithDuration(0.2, delay: 0, options: [], animations: { () -> Void in
            self.helloLabel.alpha = 0
            self.centerView.layer.shadowOpacity = 0
            
            }) { (finished) -> Void in
                self.helloLabel.text = "Me"
                self.helloLabel.font = UIFont(name: "AvenirNext-UltraLight", size: 55)
                self.helloLabel.textColor = UIColor.whiteColor()
        }
        
        //removing rippleEffect
        hideRippleBehindCenterView()
        
        animateCenterViewToNormalState()
    }
    
    /**
     Method that is called when the user has tapped on one section view. Will present the SectionSelectionViewController for the given section.
     
     - parameter gestureRecognizer: GestureRecognizer that is responsible for calling this method.
     */
    func sectionViewPressed(gestureRecognizer: UITapGestureRecognizer) {
        guard gestureRecognizer.state == .Ended else {return}
        
        
        if let tappedView = gestureRecognizer.view as? InitialViewSectionView {
            //show nextVC based on selection
            if let sectionSelectionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SectionSelectionViewController") as? SectionSelectionViewController {
                
                sectionSelectionViewController.indexOfSelectedSection = tappedView.indexOfView
                
                ttiTransitionController = TTITransitionController(modalTransitionWithPresentedViewController: sectionSelectionViewController, transitionType: .FallIn, fromPoint: centerView.center, toPoint: centerView.center, widthProportionOfSuperView: 0.8, heightProportionOfSuperView: 0.65, interactive: false, gestureType: .None, rectToStartGesture: CGRectZero)
                
                
                presentViewController(sectionSelectionViewController, animated: true, completion:nil)
                
//                indexOfLastSelectedSection()
            }
        }
    }
    
    private func animateCenterViewToNormalState() {
        let durationOfShrinking : Double = 0.25
        let durationOfGrowing : Double = 1.2
        let durationFromBigToRegular : Double = 1.1
        
        let dampingOfSpring : CGFloat = 7.0
        
        
        CATransaction .begin()
        
        let transformToSmall = CABasicAnimation(keyPath: "transform.scale")
        transformToSmall.fromValue = centerView.layer.transform.m33
        transformToSmall.toValue = NSNumber(double: 0.7)
        
//        centerView.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)
        
        transformToSmall.duration = durationOfShrinking
        transformToSmall.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let borderWidthSmall = CABasicAnimation(keyPath: "borderWidth")
        borderWidthSmall.fromValue = centerView.layer.borderWidth
        //value not kept at end of animation
        borderWidthSmall.toValue = 5
        
        borderWidthSmall.duration = durationOfShrinking
        borderWidthSmall.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        borderWidthSmall.fillMode = kCAFillModeBoth

        let corerRadiusSmall = CABasicAnimation(keyPath: "cornerRadius")
        corerRadiusSmall.duration = durationOfShrinking
        corerRadiusSmall.fromValue = centerView.layer.cornerRadius
        corerRadiusSmall.toValue = 0
        
        
        let groupSmall = CAAnimationGroup()
        groupSmall.animations = [transformToSmall, borderWidthSmall, corerRadiusSmall]
        groupSmall.duration = durationOfShrinking
        
        
        centerView.layer.addAnimation(groupSmall, forKey: "becomeSmall")
        
        
        
        
        let transformToBig = CASpringAnimation(keyPath: "transform.scale")
        transformToBig.fromValue = NSNumber(double: 0.7)
        transformToBig.toValue = NSNumber(double: 1.3)
        
        //applying transform to set layers model data correctly
//        centerView.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1.3)
        
        transformToBig.duration = durationOfGrowing
        transformToBig.damping = dampingOfSpring
        transformToBig.fillMode = kCAFillModeBoth
        
        
        
        let rotate = CASpringAnimation(keyPath: "transform.rotation.z")
        rotate.fromValue = 0
        rotate.toValue = -M_PI_2
        
        //applying transform to set layers model data correctly
//        centerView.layer.transform = CATransform3DConcat(centerView.layer.transform, CATransform3DMakeRotation(CGFloat(-M_PI_2), 0, 0, 1))
        
        rotate.damping = 1
        rotate.duration = durationOfGrowing + durationFromBigToRegular
        
        let cornerRadiusBig = CASpringAnimation(keyPath: "cornerRadius")
        cornerRadiusBig.duration = durationOfGrowing + durationFromBigToRegular
        cornerRadiusBig.damping = dampingOfSpring
        cornerRadiusBig.fromValue = 0
        cornerRadiusBig.toValue = centerView.frame.size.height / 2
        
        cornerRadiusBig.fillMode = kCAFillModeBoth
        //applying transform to set layers model data correctly
         centerView.layer.cornerRadius =  centerView.frame.size.height / 2
        
        
        let shadowDark = CABasicAnimation(keyPath: "shadowOpacity")
        shadowDark.fromValue = 0
        shadowDark.toValue = 0.5
        shadowDark.duration = durationOfGrowing + durationFromBigToRegular
        shadowDark.beginTime = 0
        shadowDark.fillMode = kCAFillModeBoth
        
        
        let borderWidthBig = CASpringAnimation(keyPath: "borderWidth")
        borderWidthBig.fromValue = 5//centerView.layer.borderWidth
        borderWidthBig.toValue = 0
        
        borderWidthBig.damping = dampingOfSpring
        borderWidthBig.duration = durationOfGrowing + durationFromBigToRegular

        
        let transformFromBigToSmall = CASpringAnimation(keyPath: "transform.scale")
        transformFromBigToSmall.fromValue = 1.3
        transformFromBigToSmall.toValue = 1.0
        transformFromBigToSmall.damping = dampingOfSpring
        transformFromBigToSmall.duration = durationFromBigToRegular
        transformFromBigToSmall.beginTime = durationOfShrinking + durationOfGrowing
        transformFromBigToSmall.fillMode = kCAFillModeBoth
        
        let groupBig = CAAnimationGroup()
        groupBig.animations = [rotate, transformToBig, cornerRadiusBig, borderWidthBig, transformFromBigToSmall]
        groupBig.beginTime = CACurrentMediaTime() + durationOfShrinking
        groupBig.duration = durationOfGrowing + durationFromBigToRegular
        
        
        
        
        //Not using the following lines to allow the animation to be deallocated and performing the changes to the layers model instead of keeping the result of animation.
//    groupBig.fillMode = kCAFillModeForwards
//        groupBig.removedOnCompletion = false

        CATransaction.setCompletionBlock { () -> Void in
            self.centerView.layer.borderWidth = 0
            
            if !self.didAnimateSectionViews {
                //animate background to color
                self.backgroundViewWithBubbles.bringInTheColorUsingAnimationWithDuration(durationOfGrowing)
                //animate section views to color
                for view in self.sectionViews {
                    view.animateToColorWithDuration(durationOfGrowing, delay: 0)
                }
            }
            
            
            //Using UIView animation for comfort.
            UIView.animateWithDuration(durationOfGrowing, animations: { () -> Void in
                self.centerView.backgroundColor = UIColor.colorFromHex(0x51C2F6)
                self.helloLabel.alpha = 1
                self.centerView.layer.shadowOpacity = 0.5
                
                }, completion: { (finished) -> Void in
                    self.didAnimateSectionViews = true
                    self.showRippleBehindSectionViewWithIndex(self.indexOfLastSelectedIndex)
            })
        }
        
        centerView.layer.addAnimation(groupBig, forKey: "becomeBig")

        
        CATransaction.commit()
        
        if !didAnimateSectionViews {
            let delayInSeconds  = Double(durationOfShrinking )
            let popTime = dispatch_time(DISPATCH_TIME_NOW,
                                        Int64(delayInSeconds * Double(NSEC_PER_SEC)))
            
            dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
                
                self.openSectionViews()
            }
            
        }
        

    }
    
    
    
    private func showRippleBehindCenterView() {
        rippleBehindCenterView = RippleEffectView(behindView: centerView, inView: view)
    }
    private func hideRippleBehindCenterView() {
        rippleBehindCenterView?.remove()
    }
    private func showRippleBehindSectionViewWithIndex(index: Int) {
        rippleBehindSectionView?.remove()
        
        guard index >= 0 && index < sectionViews.count else {
            
            highlightInfoButton()
            return
        }
        let gradientViewOfSection = sectionViews[index].gradientView
        
        let delayInSeconds  = Double(1.5)
        let popTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(delayInSeconds * Double(NSEC_PER_SEC)))

        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
            //prevent the ripple to be added twice in case the user opens on a section before 2 seconds passed 😅
            if self.indexOfLastSelectedIndex == index {
                self.rippleBehindSectionView = RippleEffectView(behindView: gradientViewOfSection, inView: self.view)
            }
        }
    }
    private func highlightInfoButton() {
    
        let translateTransform = CGAffineTransformTranslate(self.infoButton.transform, -15, -35)
        let scaleTransform = CGAffineTransformScale(translateTransform, 1.5, 1.5)
        
        UIView.animateWithDuration(0.6, delay: 1, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: [], animations: { () -> Void in
            
            self.infoButton.transform = scaleTransform
            
            }) { (_) -> Void in
                
                
                UIView.animateWithDuration(0.6, delay: 0.5, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: [], animations: { () -> Void in
                    
                        self.infoButton.transform = CGAffineTransformIdentity
                    
                    
                    }, completion: { (_) -> Void in
                        
                })
                
                
        }
    }

    // MARK: - Navigation


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowInfo", let destination = segue.destinationViewController as? InfoViewController, let pressedButton = sender as? UIButton {
            
            
            let fromPoint = pressedButton.center

            destination.view.tintColor = view.tintColor
            
            ttiTransitionController = TTITransitionController(modalTransitionWithPresentedViewController: destination, transitionType: TTITransitionType.Full, fromPoint: fromPoint, toPoint: fromPoint, widthProportionOfSuperView: 0.9, heightProportionOfSuperView: 0.9, interactive: false, gestureType: .None, rectToStartGesture: CGRectZero)
        }
    }

    

    @IBAction func unwindToInitialViewController(unwindSegue: UIStoryboardSegue) {
        indexOfLastSelectedIndex += 1
        showRippleBehindSectionViewWithIndex(indexOfLastSelectedIndex)
    }

}

// MARK: - UIViewControllerPreviewingDelegate
extension InitialViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        
        if previewingContext.sourceView === centerView {
            //do nothing because the image should only be previewable.
            return
        }

        // Reuse the "Peek" view controller for presentation.
        presentViewController(viewControllerToCommit, animated: true, completion: nil)
        
    }
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        switch previewingContext.sourceView {
        case centerView:
            previewingContext.sourceRect = view.convertRect(centerView.bounds, toView: nil)
            
            let imageViewController = storyboard?.instantiateViewControllerWithIdentifier("ForceTouchImageViewController")
            imageViewController?.preferredContentSize = CGSize(width: 300, height: 250)
            
            return imageViewController

            
        case infoButton:
            previewingContext.sourceRect = view.convertRect(view.bounds, toView: nil)
            let infoController = storyboard!.instantiateViewControllerWithIdentifier("InfoViewController")
            infoController.modalPresentationStyle = .OverFullScreen
            infoController.view.tintColor = view.tintColor
            
            return infoController

        default:
            if let selectedView = previewingContext.sourceView as? InitialViewSectionView {
                previewingContext.sourceRect = view.convertRect(view.bounds, toView: nil)
                let selctedSectionValues = selectedView.sectionValues
                
                if let sectionNavigationController = storyboard!.instantiateViewControllerWithIdentifier(selctedSectionValues.identifierOfViewControllerInStoryboard) as? SectionMainNavigationViewController {
                    
                    sectionNavigationController.setSectionValues(selectedView.indexOfView)
                    sectionNavigationController.modalPresentationStyle = .OverFullScreen
                    
                    return sectionNavigationController
                    
                }

            }
            
        }

        return nil
    }
}