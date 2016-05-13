//
//  OutlinedLabelView.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 06.09.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit
import QuartzCore

/// UIView subclass that draws a given CGPath. It is used to draw the outlined-label and that is why I chose this name.
final class OutlinedLabelView: UIView {
    
        /// Path that shall be drawn inside of this view.
    var pathOfLabel : CGPath? {
        didSet {
            prepareLayer()
        }
    }
        /// Color of the path.
    var strokeColor : UIColor? {
        didSet {
            prepareLayer()
        }
    }
    
        /// Line width of the path.
    var lineWidth : CGFloat = 2.0 {
        didSet {
            prepareLayer()
        }
    }
        /// Flag that indicates if the path should be centered within this view. If not, is is positioned at its origin (0,0).
    var shouldBeCentered = true {
        didSet {
            prepareLayer()
        }
    }
    
        /// Progress of the path. It will update the paths strokeEnd. Use this method to propagate updates to the path.
    var progressOfStroke : CGFloat = 0 {
        didSet {
            guard progressOfStroke >= 0 && progressOfStroke <= 1 else{return}
            
            pathLayer.strokeEnd = progressOfStroke

        }
    }
    

    private let pathLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        //        pathLayer = CAShapeLayer()
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = UIColor.clearColor()
//        prepareLayer()
    }
    
    private func prepareLayer() {
        pathLayer.removeFromSuperlayer()
        
        pathLayer.path = pathOfLabel
        pathLayer.strokeColor = strokeColor?.CGColor ?? UIColor.orangeColor().CGColor
        pathLayer.fillColor = nil
        pathLayer.lineWidth = lineWidth
        pathLayer.miterLimit = lineWidth
        pathLayer.lineCap = kCALineCapRound
        pathLayer.masksToBounds = true
        
        let strokingPath = CGPathCreateCopyByStrokingPath(pathLayer.path, nil, 4, CGLineCap.Round, CGLineJoin.Miter, 4)
//        print(CGPathGetPathBoundingBox(strokingPath))
        
        pathLayer.bounds = CGPathGetPathBoundingBox(strokingPath)
        if shouldBeCentered {
            pathLayer.position = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds))
        }
        else {
            pathLayer.frame = bounds
        }

        pathLayer.strokeEnd = 0
        
        layer.addSublayer(pathLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    /**
     Method that animated the path to a finished state, meaning that progressOfStroke and thereby strokeEnd will be 1.
     */
    func animateToFinish() {
        let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        
        strokeEnd.fromValue = pathLayer.presentationLayer()?.strokeEnd
        
        strokeEnd.toValue = 1
        
        strokeEnd.duration = 3.0
        
        pathLayer.addAnimation(strokeEnd, forKey: "strokeEnd")
        progressOfStroke = 1
        //        (pathLayer.modelLayer() as! CAShapeLayer).strokeEnd = 1
        
    }

}
