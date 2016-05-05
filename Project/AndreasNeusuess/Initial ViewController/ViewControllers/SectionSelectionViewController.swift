//
//  SectionSelectionViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 29.08.15.
//  Copyright © 2015 Anerma. All rights reserved.
//

import UIKit

/// ViewController that provides a short introduction about a given section. Will be presented when user taps on an initialView.
final class SectionSelectionViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var bodyText: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var headerBackgroundGradientView: GradientView!
    @IBOutlet weak var bodyBackgroundView: UIView!

        /// Index of the selected section.
    var indexOfSelectedSection : Int!
    
    private var sectionValues : SectionValues!
    private var ttiTransitionController: TTITransitionController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func updateUI() {
        guard indexOfSelectedSection >= 0 && indexOfSelectedSection < 7 else {return}
        
        sectionValues = SectionValuesStore.sectionValuesForViewAtIndex(indexOfSelectedSection)
        
        headerBackgroundGradientView.startColor = sectionValues.gradientStartColor
        headerBackgroundGradientView.endColor = sectionValues.gradientEndColor
        bodyBackgroundView.backgroundColor = sectionValues.backgroundColor
        headerLabel.text = sectionValues.sectionTitle
        bodyText.text = sectionValues.sectionBodyText
        
        view.tintColor = sectionValues.tintColor
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func moreButtonPressed(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let identifier = sectionValues.identifierOfViewControllerInStoryboard
        
        if let sectionNavigationController = storyboard.instantiateViewControllerWithIdentifier(identifier) as? SectionMainNavigationViewController {
            
            sectionNavigationController.setSectionValues(indexOfSelectedSection)
            
//            sectionNavigationController.indexOfSelectedSection = indexOfSelectedSection
            
            ttiTransitionController = TTITransitionController(modalTransitionWithPresentedViewController: sectionNavigationController, transitionType: .Full, fromPoint: sender.center, toPoint: sender.center, widthProportionOfSuperView: 1, heightProportionOfSuperView: 1, interactive: false, gestureType: .LeftEdge, rectToStartGesture: CGRectZero)
            
            presentViewController(sectionNavigationController, animated: true, completion: {self.view.alpha = 0})
            
            
        }
    }
    @IBAction func closeButtonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   

}
This line will prevent compiling.

Please note the copyright and be so kind to play along.

If you would like to use parts of the app, please contact me :)