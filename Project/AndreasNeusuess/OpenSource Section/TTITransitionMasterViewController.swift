//
//  TTITransitionMasterViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 14.11.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit

/// ViewController in which I demo TTITransition. It transitions into the detail... ViewController.
final class TTITransitionMasterViewController: UIViewController {
    private var transitionController : TTITransitionController!

    @IBOutlet weak var imageViewToTakeAlong: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destination = segue.destinationViewController as! TTITransitionDetailViewController
        let fromPoint = (sender as! UIButton).center
        let toPoint = CGPoint(x: CGRectGetMidX(view.frame), y: 0)
        let rectToStartGesture = CGRectMake(50, 50, 100, 100)
        
        switch segue.identifier! {
            case "ShowModalOverlay":
                transitionController = TTITransitionController(modalTakeAlongTransitionWithPresentedViewController: destination, presentingViewController: self, transitionType: .Overlay, fromPoint: fromPoint, toPoint: CGPoint(x: CGRectGetMidX(view.frame), y: CGRectGetMaxY(view.frame)), widthProportionOfSuperView: 0.8, heightProportionOfSuperView: 0.8, interactive: true, gestureType: TTIGestureRecognizerType.Pinch, rectToStartGesture: rectToStartGesture)
            destination.shouldShowRectToDismiss = false
            destination.textToDisplayInHowToCloseLabel = "Please pinch to close the ViewController.\nYou also could use this button if you want to."
            
            case "ShowModalFold":
                transitionController = TTITransitionController(modalTakeAlongTransitionWithPresentedViewController: destination, presentingViewController: self, transitionType: .Fold, fromPoint: fromPoint, toPoint: fromPoint, widthProportionOfSuperView: 0.8, heightProportionOfSuperView: 0.8, interactive: true, gestureType: TTIGestureRecognizerType.LeftEdge, rectToStartGesture: CGRectZero)
                
                destination.shouldShowRectToDismiss = false
                destination.textToDisplayInHowToCloseLabel = "Please swipe in from the left edge to close the ViewController.\nYou also could use this button."
            
            case "ShowModalSlide":
                transitionController = TTITransitionController(modalTakeAlongTransitionWithPresentedViewController: destination, presentingViewController: self, transitionType: .Slide, fromPoint: fromPoint, toPoint: fromPoint, widthProportionOfSuperView: 1, heightProportionOfSuperView: 1, interactive: true, gestureType: .LeftEdge, rectToStartGesture: CGRectZero)
                
                destination.shouldShowRectToDismiss = false
                destination.textToDisplayInHowToCloseLabel = "Please swipe in from the left edge to close the ViewController.\nYou also could use this button."
            
            case "ShowModalFallIn":
                transitionController = TTITransitionController(modalTransitionWithPresentedViewController: destination, transitionType: .FallIn, fromPoint: fromPoint, toPoint: toPoint, widthProportionOfSuperView: 0.7, heightProportionOfSuperView: 0.7, interactive: true, gestureType: TTIGestureRecognizerType.PanToEdge, rectToStartGesture: rectToStartGesture)
                
                destination.shouldShowRectToDismiss = true
                destination.shouldShowImageView = false
                destination.textToDisplayInHowToCloseLabel = "Please grab the view on the highlighted rectangle and swipe it upwards.\nThis transition could be used for some kind of modal alert or a ViewController with detailed information."
            
            case "ShowModalHangInto":
                transitionController = TTITransitionController(modalTransitionWithPresentedViewController: destination, transitionType: .HangIn, fromPoint: fromPoint, toPoint: fromPoint, widthProportionOfSuperView: 0.8, heightProportionOfSuperView: 0.7, interactive: true, gestureType: TTIGestureRecognizerType.PullUpDown, rectToStartGesture: rectToStartGesture)
                
                destination.shouldShowRectToDismiss = false
                destination.shouldShowImageView = false
                destination.textToDisplayInHowToCloseLabel = "This transition could be used for an alert or something simmilar."
            
            case "ShowNavigationFold":
            
            transitionController = TTITransitionController(navigationControllerTransitionWithTakeAlongElementsInNavigationController: navigationController!, presentedViewController: destination, presentingViewController: self, transitionType: .Fold)
            
            destination.shouldShowCloseButton = false
            destination.textToDisplayInHowToCloseLabel = "You are seeing a UINavigationController transition. Most of the TTITransitions also support those kind of transitions.\nIf you swipe from the right edge, you can navigate back."

            default:
                ()
            
        }
        
        destination.tintColor = view.tintColor
    }
    

}

// MARK: - TTITakeAlongTransitionProtocolForPresenting Methods
extension TTITransitionMasterViewController : TTITakeAlongTransitionProtocolForPresenting {
    func dataForTakeAlongTransition() -> [TTITakeAlongData]! {
        
        let imageViewData = TTITakeAlongData(initialView: imageViewToTakeAlong, key: "imageView")
        return [imageViewData]
    }
}