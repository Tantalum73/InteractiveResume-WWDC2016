//
//  TTITransitionDetailViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 14.11.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit

/// ViewController in which I demo TTITransition. This ViewController will be presented using TTITransition.
final class TTITransitionDetailViewController: UIViewController {

    @IBOutlet weak var imageViewToTakeAlong: UIImageView!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var howToCloseLabel: UILabel!
    
    var shouldShowRectToDismiss = false
    var shouldShowCloseButton = true
    var shouldShowImageView = true
    var textToDisplayInHowToCloseLabel : String = ""
    var tintColor : UIColor?
    
    private let rectForInteraction = CGRect(x: 50, y: 50, width: 100, height: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showRectToDismiss()
        howToCloseLabel.text = textToDisplayInHowToCloseLabel
        
        view.tintColor = tintColor
        closeButton.hidden = !shouldShowCloseButton
        imageViewToTakeAlong.hidden = !shouldShowImageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closeButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func showRectToDismiss() {
        guard shouldShowRectToDismiss == true else {return}
        let gradient = GradientView(frame: rectForInteraction)
        gradient.cornerRadius = 10
        
        view.addSubview(gradient)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let transitionController = transitioningDelegate as? TTITransitioningDelegate else {return}
        
        transitionController.rectForPanGestureToStart = rectForInteraction
    }

}

// MARK: - TTITakeAlongTransitionProtocolForPresented Method
extension TTITransitionDetailViewController : TTITakeAlongTransitionProtocolForPresented {
    func takeAlongDataWithPopulatedFinalFramesForTakeAlongData(takeAlongDataToPopulate: TTITakeAlongData!) {
        
        takeAlongDataToPopulate.finalView  = imageViewToTakeAlong
    }
}