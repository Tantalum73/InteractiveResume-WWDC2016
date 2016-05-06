//
//  SectionMainNavigationViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 01.09.15.
//  Copyright © 2015 Anerma. All rights reserved.
//

import UIKit

/// A protocol that defines methods to inject section values into a new object (mainly new ViewControllers).
protocol SectionValuesSettable: class {
        /// SectionValues to style the receiver.
    var sectionValues : SectionValues! {get set}
        /// Index of the given section. Used to gather sectionValues data.
    var sectionIndex: Int! {get set}

}
// MARK: - SectionValuesSettable Extension to provide a method for setting SectionValues by setting a given index.
extension SectionValuesSettable {
    /**
     Couples SectionValues to a given index. When this method is called with a given index, both values will be updated.
     
     
     - parameter index: Index of the section.
     */
    func setSectionValues(index: Int) {
        self.sectionIndex = index
        self.sectionValues = SectionValuesStore.sectionValuesForViewAtIndex(index)
    }
}

@IBDesignable
/// UINavigationController subclass that handles styling of the toolbar for a given section. Every UINavigationController that is opened from the SectionSelectionViewController should inherit from it.
class SectionMainNavigationViewController: UINavigationController, SectionValuesSettable {

    
    @IBInspectable
    var navigationBarHasGradient = false {
        didSet {
            updateUI()
        }
    }
    /// SectionValues to style the receiver.
    var sectionValues : SectionValues!
    
    /// Index of the given section. Used to gather sectionValues data.
    var sectionIndex: Int! = 2
    
    private lazy var gradientBackground : GradientView = GradientView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
        setSectionValuesToViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    
    /**
     Sets the specified SectionValues to its children.
     */
    private func setSectionValuesToViewControllers() {
        for viewController in viewControllers {
            guard let viewController = viewController as? SectionValuesSettable else{continue}
            
            viewController.setSectionValues(sectionIndex)
        }
    }
    
    /**
     Updates the UI of the NavigationBar based on the specified SectionValues.
     */
    private func updateUI() {
        guard sectionIndex >= 0 && sectionIndex < 7 else {return}
        
        sectionValues = SectionValuesStore.sectionValuesForViewAtIndex(sectionIndex)
        
        if navigationBarHasGradient {
            gradientBackground.removeFromSuperview()
//            let frameForGradient = CGRect(x: 0, y: 0, width: CGRectGetMaxX(navigationBar.frame), height: CGRectGetMaxY(navigationBar.frame))
            
            gradientBackground.frame = navigationBar.bounds
            gradientBackground.startColor = sectionValues.gradientStartColor
            gradientBackground.endColor = sectionValues.gradientEndColor
            
            
            navigationBar.insertSubview(gradientBackground, atIndex: 1)
        }
        
        
        
        view.tintColor = sectionValues.tintColor
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.barTintColor = sectionValues.gradientStartColor
        navigationBar.translucent = false
    }
}
This line will prevent compiling.

Please note the copyright and be so kind to play along.

If you would like to use parts of the app, please contact me :)