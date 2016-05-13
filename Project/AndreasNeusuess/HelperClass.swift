//
//  HelperClass.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 28.08.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit
import SafariServices


/**
 *  Protocol that declares a method to present a SafariViewController.
 */
protocol SafariViewControllerPresentable {
    /**
     Presenting a SafariViewController that opens a given URL.
     
     - parameter url: The URL that shall be opened by the SafariViewController.
     */
    func showSafariViewControllerWithURL(url: NSURL?)
}

// MARK: - SafariViewControllerPresentable Extension
extension SafariViewControllerPresentable where Self : UIViewController {
    func showSafariViewControllerWithURL(url: NSURL?) {
        guard let url = url else {return}
        
        let safariVC = SFSafariViewController(URL: url)
        presentViewController(safariVC, animated: true, completion: nil)
        
    }
}
// MARK: - UIColor Extension
extension UIColor {

    /**
     UIColor from a given hex value.
     
     - parameter hex:   The hex value to be converted to UIColor
     - parameter alpha: Alpha value of the color
     
     - returns: UIColor corresponding to the given hex and alpha value
     */
    class func colorFromHex (hex: Int, alpha: Double = 1.0) -> UIColor {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF)) / 255.0
        let color: UIColor = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha:CGFloat(alpha) )
        return color
    }


    /**
     UIColor from rgb value.
     
     - parameter red:   Red value.
     - parameter green: Green value.
     - parameter blue:  Blue value.
     
     - returns: UIColor constructed by the given value.
     */
    class func colorFromRGB (red: Int, green: Int, blue: Int) -> UIColor {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        return self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    /**
     UIColor from hex String.
     
     - parameter rgba: Hex string in format like #FF00AA
     
     - throws: <#throws value description#>
     
     - returns: UIColor from hex String.
     */
    class func colorFromHexString (rgba: String) throws -> UIColor {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index   = rgba.startIndex.advancedBy(1)
            let hex     = rgba.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                
                switch (hex.characters.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
                }
            } else {
                print("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix")
        }
        return self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}

// MARK: - Array  Extension
extension Array {
    /**
     Selects random element form that array.
     
     - returns: Random element.
     */
    func randomItem() ->Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

// MARK: - UIView  Extension
extension UIView {
    /**
     Adds motion effects with specified parameters.
     
     - parameter deltaX: Maximal TiltAlongHorizontalAxis, from (-deltaX) to (+deltaX)
     - parameter deltaY: Maximal TiltAlongVerticalAxis, from (-deltaY) to (+deltaY)
     */
    func addMotionEffects(deltaX deltaX: Double, deltaY: Double) {
        
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        
        horizontalMotionEffect.minimumRelativeValue = -deltaX
        horizontalMotionEffect.maximumRelativeValue = deltaX
        
        verticalMotionEffect.minimumRelativeValue = -deltaY
        verticalMotionEffect.maximumRelativeValue = deltaY
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [verticalMotionEffect, horizontalMotionEffect]
        
        addMotionEffect(motionEffectGroup)

    }
    /**
     Adds motion effects for shadow of the view with specified parameters.

     
     - parameter height: Maximal TiltAlongHorizontalAxis, from (-width) to (+width)
     - parameter width:  Maximal TiltAlongVerticalAxis, from (-height) to (+height)

     */
    func addMotionEffectsForShadow(height height: Double, width: Double) {
        
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "layer.shadowOffset.width", type: .TiltAlongHorizontalAxis)
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "layer.shadowOffset.height", type: .TiltAlongVerticalAxis)
        
        horizontalMotionEffect.minimumRelativeValue = -width
        horizontalMotionEffect.maximumRelativeValue = width
        
        verticalMotionEffect.minimumRelativeValue = -height
        verticalMotionEffect.maximumRelativeValue = height
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [verticalMotionEffect, horizontalMotionEffect]
        
        addMotionEffect(motionEffectGroup)
        
    }
}

