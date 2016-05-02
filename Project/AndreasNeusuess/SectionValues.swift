//
//  SectionValues.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 29.08.15.
//  Copyright © 2015 Anerma. All rights reserved.
//

import Foundation
import UIKit

/**
 *  Struct to hold section configration data like tintColor or StoryboardIdentifier for the ViewController.
 */
struct SectionValues {
        /// Tint color of view.
    let tintColor : UIColor
        /// Main background color.
    let backgroundColor: UIColor
        /// Start color of the linear gradient.
    let gradientStartColor: UIColor
        /// End color of the linear gradient.
    let gradientEndColor: UIColor
        /// Title of the given section.
    let sectionTitle: String
        /// Taser text of this section. Presented if user opens section teaser in InitialView.
    let sectionBodyText: String
        /// Identifier string of the corresponding ViewController.
    let identifierOfViewControllerInStoryboard: String
    
    init(tintColor: UIColor, backgroundColor: UIColor, gradientStartColor: UIColor, gradientEndColor: UIColor, sectionTitle: String, sectionBodyText: String, identifierOfViewControllerInStoryboard: String) {
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        self.gradientStartColor = gradientStartColor
        self.gradientEndColor = gradientEndColor
        self.sectionTitle = sectionTitle
        self.sectionBodyText = sectionBodyText
        self.identifierOfViewControllerInStoryboard = identifierOfViewControllerInStoryboard
    }
}
/**
 *  Struct that holds the values for the sections.
 */
struct SectionValuesStore {
    private struct tintColors {
        ///Red section
        static let red = UIColor.colorFromHex(0xFF6A6A, alpha: 1)
        ///Orange section
        static let orange = UIColor.colorFromHex(0xF8551E, alpha: 1)
        ///Green section
        static let green = UIColor.colorFromHex(0x25B15F, alpha: 1)
        ///Purple section
        static let purple = UIColor.colorFromHex(0xF53D77, alpha: 1)
        //Blue section
        static let blue = UIColor.colorFromHex(0x2D60C2, alpha: 1)
        //Light Blue section
        static let cyan = UIColor.colorFromHex(0x059AB1, alpha: 1)
        //Yellow section
        static let yellow = UIColor.colorFromHex(0xF2F706, alpha: 1)
    }
    private struct backgroundColors {
        static let red = UIColor.colorFromHex(0xFFA9A9, alpha: 1)
        static let orange = UIColor.colorFromHex(0xF7A677, alpha: 1)
        static let green = UIColor.colorFromHex(0x82D2A4, alpha: 1)
        static let purple = UIColor.colorFromHex(0x7C05F7, alpha: 1)
        static let blue = UIColor.colorFromHex(0x88C7F6, alpha: 1)
        static let cyan = UIColor.colorFromHex(0x53D5DF, alpha: 1)
        static let yellow = UIColor.colorFromHex(0x333333, alpha: 1)
    }
    private struct gradientStartColors {
        static let red = UIColor.colorFromHex(0xFF9F9F, alpha: 1)
        static let orange = UIColor.colorFromHex(0xFC9B57, alpha: 1)
        static let green = UIColor.colorFromHex(0xACE1C2, alpha: 1)
        static let purple = UIColor.colorFromHex(0x6303C7, alpha: 1)
        static let blue = UIColor.colorFromHex(0x89CEFC, alpha: 1)
        static let cyan = UIColor.colorFromHex(0x89FCD9, alpha: 1)
        static let yellow = UIColor.colorFromHex(0x676764, alpha: 1)
    }
    private struct gradientEndColors {
        static let red = UIColor.colorFromHex(0xFF6969, alpha: 1)
        static let orange = UIColor.colorFromHex(0xF8551E, alpha: 1)
        static let green = UIColor.colorFromHex(0x31B568, alpha: 1)
        static let purple = UIColor.colorFromHex(0x5A02B5, alpha: 1)
        static let blue = UIColor.colorFromHex(0x2D5FC1, alpha: 1)
        static let cyan = UIColor.colorFromHex(0x21D9F5, alpha: 1)
        static let yellow = UIColor.colorFromHex(0x4D4E4C, alpha: 1)
    }
    private struct sectionTitles {
        static let red = "About Me"
        static let orange = "Education"
        static let green = "Skills"
        static let purple = "Goals"
        static let blue = "iOS Projects"
        static let cyan = "Open Source"
        static let yellow = "Life"
    }
    private struct sectionBodyTexts {
        static let red = "An excellent place to start.\nHere I am going to give you an introduction about me, where I live and where I come from."
        
        static let orange = "An overview of my skills and what programming techniques I have learned yet awaits you in this section.\nLet’s take a look!"
        
        static let green = "An overview of my skills and what programming techniques I have learned yet awaits you in this section.\nLet’s take a look!"
        
        static let purple = "‘Where do we all come from’ is a question humanity wonders since the beginning of time.\nI however am wondering ‘where do I want to be’.\nThe answer ist not 42 for that one."
        
        static let blue = "I take special care of my iOS apps which results in not many but high quality projects.\nBe my guest as I present them to you."
        
        static let cyan = "Of course, I contribute to the Open Source community as well.\nLet me show, what I have to offer to the community."
        
        static let yellow = "Now it’s going to get personal.\nSit down with me and let’s have a look at my life and personality (at least as far as I can describe it) in this section."
    }
    private struct identifiersForViewController {
        static let red = "SectionMainNavigationViewControllerPerson"
        static let orange = "SectionMainNavigationViewControllerEducation"
        static let green = "SectionMainNavigationViewControllerSkills"
        static let purple = "SectionMainNavigationViewControllerGoals"
        static let blue = "SectionMainNavigationViewControlleriOSApps"
        static let cyan = "SectionMainNavigationViewControllerOpenSource"
        static let yellow = "SectionMainNavigationViewControllerLife"
    }
    
    /**
     Composes SectionValues struct for a section at a given index.
     
     - parameter index: Index of the section whose values are requested.
     
     - returns: SectionValues of the specified section.
     */
    static func sectionValuesForViewAtIndex(index: Int) -> SectionValues {
        assert(index >= 0 && index < 7, "Index value must be between 0 and 6")

        switch index {
        case 0:
            return SectionValues(tintColor: tintColors.red,
                backgroundColor: backgroundColors.red,
                gradientStartColor: gradientStartColors.red,
                gradientEndColor: gradientEndColors.red,
                sectionTitle: sectionTitles.red,
                sectionBodyText: sectionBodyTexts.red,
                identifierOfViewControllerInStoryboard: identifiersForViewController.red)
        case 1:
            return SectionValues(tintColor: tintColors.orange,
                backgroundColor: backgroundColors.orange,
                gradientStartColor: gradientStartColors.orange,
                gradientEndColor: gradientEndColors.orange,
                sectionTitle: sectionTitles.orange,
                sectionBodyText: sectionBodyTexts.orange,
                identifierOfViewControllerInStoryboard: identifiersForViewController.orange)
        case 2:
            return SectionValues(tintColor: tintColors.green,
                backgroundColor: backgroundColors.green,
                gradientStartColor: gradientStartColors.green,
                gradientEndColor: gradientEndColors.green,
                sectionTitle: sectionTitles.green,
                sectionBodyText: sectionBodyTexts.green,
                identifierOfViewControllerInStoryboard: identifiersForViewController.green)
        case 3:
            return SectionValues(tintColor: tintColors.cyan,
                backgroundColor: backgroundColors.cyan,
                gradientStartColor: gradientStartColors.cyan,
                gradientEndColor: gradientEndColors.cyan,
                sectionTitle: sectionTitles.cyan,
                sectionBodyText: sectionBodyTexts.cyan,
                identifierOfViewControllerInStoryboard: identifiersForViewController.cyan)
            
        case 4:
            return SectionValues(tintColor: tintColors.blue,
                backgroundColor: backgroundColors.blue,
                gradientStartColor: gradientStartColors.blue,
                gradientEndColor: gradientEndColors.blue,
                sectionTitle: sectionTitles.blue,
                sectionBodyText: sectionBodyTexts.blue,
                identifierOfViewControllerInStoryboard: identifiersForViewController.blue)
        case 5:
            return SectionValues(tintColor: tintColors.purple,
                backgroundColor: backgroundColors.purple,
                gradientStartColor: gradientStartColors.purple,
                gradientEndColor: gradientEndColors.purple,
                sectionTitle: sectionTitles.purple,
                sectionBodyText: sectionBodyTexts.purple,
                identifierOfViewControllerInStoryboard: identifiersForViewController.purple)
        case 6:
            return SectionValues(tintColor: tintColors.yellow,
                backgroundColor: backgroundColors.yellow,
                gradientStartColor: gradientStartColors.yellow,
                gradientEndColor: gradientEndColors.yellow,
                sectionTitle: sectionTitles.yellow,
                sectionBodyText: sectionBodyTexts.yellow,
                identifierOfViewControllerInStoryboard: identifiersForViewController.yellow)
        default:
            let gray = UIColor.grayColor()
            return SectionValues(tintColor: gray,
                backgroundColor: gray, gradientStartColor:
                gray, gradientEndColor: gray,
                sectionTitle: "NONE",
                sectionBodyText: "NONE",
                identifierOfViewControllerInStoryboard: "NONE")
        }
    }
}