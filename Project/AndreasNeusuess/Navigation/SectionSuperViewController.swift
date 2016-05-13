//
//  SectionSuperViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 05.09.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit

/// UIViewController subclass that handles styling in a unified way. Subclasses of this class will be able to use a SectionViewControllerHeaderController in a unified way. Every ViewControllers that contain a 'Header' (in a SectionViewControllerHeaderController way) should inherit from this class.
class SectionSuperViewController: UIViewController, SectionValuesSettable {

    /// SectionValues to style the receiver.
    var sectionValues : SectionValues!
    
    /// Index of the given section. Used to gather sectionValues data.
    var sectionIndex: Int!

    /// FadingNavigationBarTitleViewController that is responsible for handling UI changes and behaviour of the 'header'.
    var fadingNavBarTitleController: FadingNavigationBarTitleViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    /**
     Constructs a SectionViewControllerHeaderController that is responsible for handling the mechanism for the scrolling-navigation-bar-label.
     We stores this object in our 'headerController' var.
     It also updates the color for a given GradientView based on 
     UIScrollViewDelegate methods **must** be propagated to this object in oder to work properly by using its updateNavBarTitleViewInScrollView(_) method.
     
     - parameter navigationController:      UINavigationController in which the calling ViewController is placed.
     - parameter labelThatBecomesTitleView: A UILabel that will be used as the header. This label will move from the ViewController to its NavigationController NavigationBar.
     - parameter gradientView:              Gradient View in which the label is placed. The styling will also be done there.
     */
    func setUpHeaderControllerWithNavigationController(navigationController: UINavigationController, labelThatBecomesTitleView: UILabel, gradientView: GradientView?) {
        
        styleGradientView(gradientView, basedOnSectionValues: sectionValues)
        
        fadingNavBarTitleController = FadingNavigationBarTitleViewController(inViewController: self, inNavigationController: navigationController, viewThatBecomesTitleView: labelThatBecomesTitleView)

    }
    
    /**
     Styles a given GradientView with given SectionValues.
     
     - parameter gradientView:  GradientView that shall be styled.
     - parameter sectionValues: SectionValues that holds values for styling the GradientView.
     */
    private func styleGradientView(gradientView: GradientView?, basedOnSectionValues sectionValues: SectionValues) {
        
        guard let gradient = gradientView else {return}
        
        gradient.startColor = sectionValues.gradientStartColor
        gradient.endColor = sectionValues.gradientEndColor
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
This lines will prevent compiling.

Please note the copyright and be so kind to play along. Please refrain from copying or modifying.

If you would like to use parts of the app, please contact me :)