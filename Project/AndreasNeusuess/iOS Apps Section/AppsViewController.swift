//
//  AppsViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 16.09.15.
//  Copyright © 2015 Anerma. All rights reserved.
//

import UIKit

/**
 Enum that can be either TourTime or ClubNews. Used to distinguish between apps, it enables distinguishability in code sharing of both ViewControllers.
 
 - TourTime: TourTime
 - ClubNews: ClubNews
 */
public enum TypeOfApp {
    case TourTime, ClubNews
}

/// UIViewController, subclass of SectionSuperViewController that presents my current apps. The user can select TourTime or ClubNews to open those detail ViewControllers.
final class AppsViewController: SectionSuperViewController {
    
        /// Gradient header view.
    @IBOutlet weak var gradientHeaderView: GradientView!

    ///View behind the app icon. Used to subclass SelectableView that is responsible for shrinking when the user taps on the view.
    @IBOutlet weak var tourTimeBackgroundView: SelectableView! {
        didSet {
            tourTimeBackgroundView.shouldAddOverlay = false
        }
    }
    ///View behind the app icon. Used to subclass SelectableView that is responsible for shrinking when the user taps on the view.
    @IBOutlet weak var clubNewsBackgroundView: SelectableView! {
        didSet {
            clubNewsBackgroundView.shouldAddOverlay = false
        }
    }
    ///StackView to add a GestureRecognizer to.
    @IBOutlet weak var tourTimeStackView: UIStackView! {
        didSet {
            let gr = UITapGestureRecognizer(target: self, action: #selector(AppsViewController.tourTimeStackViewTapped(_:)))
            
            tourTimeStackView.addGestureRecognizer(gr)
            
        }
    }
    ///StackView to add a GestureRecognizer to.
    @IBOutlet weak var clubNewsStackView: UIStackView! {
        didSet {
            let gr = UITapGestureRecognizer(target: self, action: #selector(AppsViewController.clubNewsStackViewTapped(_:)))
            clubNewsStackView.addGestureRecognizer(gr)
        }
    }
    ///ImageView that displays the app icon. Used to perform highlight changes onto.
    @IBOutlet weak var tourTimeImageView: UIImageView!
    ///ImageView that displays the app icon. Used to perform highlight changes onto.
    @IBOutlet weak var clubNewsImageView: UIImageView!
    
    private var transitionController : TTITransitionController!
    private var typeOfSelectedApp = TypeOfApp.ClubNews
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tourTimeBackgroundView.viewToBeHighlighted = tourTimeImageView

        gradientHeaderView.startColor = sectionValues.gradientStartColor
            gradientHeaderView.endColor = sectionValues.gradientEndColor


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Navigation
    
    /**
     Target method for UITapGestureRecognizer that registers taps on ClubNews.
     
     - parameter gestureRecognizer: The UITapGestureRecognizer that fired.
     */
    func clubNewsStackViewTapped(gestureRecognizer: UITapGestureRecognizer) {
        handleTapOnStackView(withType: .ClubNews, gestureRecognizer: gestureRecognizer)
    }
    /**
     Target method for UITapGestureRecognizer that registers taps on TourTime.
     
     - parameter gestureRecognizer: The UITapGestureRecognizer that fired.
     */
    func tourTimeStackViewTapped(gestureRecognizer: UITapGestureRecognizer) {
        handleTapOnStackView(withType: .TourTime, gestureRecognizer: gestureRecognizer)
    }
    
    /**
     Method that handles gesture recognizer methods. Because a UITapGestureRecognizer can only be attached to one view, this methods unites the code that handles the action.
     
     - parameter type:              Type of app whose GestureRecognizer has fired.
     - parameter gestureRecognizer: The UITapGestureRecognizer that fired.
     */
    private func handleTapOnStackView(withType type: TypeOfApp, gestureRecognizer: UITapGestureRecognizer) {
        guard gestureRecognizer.state == .Ended else{return}
        
        let identifierForNewViewController : String
        switch type {
        case .TourTime:
            identifierForNewViewController = "TourTimeInfoViewController"
        case .ClubNews:
            identifierForNewViewController = "ClubNewsInfoViewController"
        }
        
        let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(identifierForNewViewController) as! AppsDetailViewController
        
        newViewController.sectionValues = sectionValues
        typeOfSelectedApp = type
        
        transitionController = TTITransitionController(navigationControllerTransitionWithTakeAlongElementsInNavigationController: navigationController!, presentedViewController: newViewController, presentingViewController: self, transitionType: .Fold)
        
        navigationController!.pushViewController(newViewController, animated: true)
    }


}

// MARK: - TTITakeAlongTransitionProtocolForPresenting
extension AppsViewController : TTITakeAlongTransitionProtocolForPresenting {
    func dataForTakeAlongTransition() -> [TTITakeAlongData]! {
        let data : TTITakeAlongData
        
        switch typeOfSelectedApp {
        case .TourTime:
            data = TTITakeAlongData(initialView: tourTimeImageView, key: "AppIcon")
        case .ClubNews:
            data = TTITakeAlongData(initialView: clubNewsImageView, key: "AppIcon")
        }
        
        return [data]
        
    }
}