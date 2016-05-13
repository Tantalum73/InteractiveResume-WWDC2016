//
//  SeperatorView.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 12.09.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit

@IBDesignable
/// A simple UIView subclass that draws a line. It is ought to be used as a separator line. (Yes, I am aware of the typo 😅). It plays nicely with InterfaceBuilder.
final class SeperatorView: UIView {
    
        /// Color of the separator.
    @IBInspectable var color: UIColor = UIColor.colorFromHex(0x979797)
        /// Line width of the separator, therefore basically the height. I recommend to set the height (via autolayout) at least to this value.
    @IBInspectable var lineWidth : CGFloat = 1.0
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        let leftStart = CGRectGetMinX(rect) + lineWidth
        let rightEnd = CGRectGetMaxX(rect) - lineWidth
        let y = CGRectGetMidY(rect)
        
        let path = UIBezierPath()
        
        path.lineWidth = lineWidth
        path.lineCapStyle = .Round
        
        path.moveToPoint(CGPointMake(leftStart, y))
        path.addLineToPoint(CGPointMake(rightEnd, y))
        
        UIColor.clearColor().setFill()
        color.setStroke()
        
        path.stroke()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
    }

}
