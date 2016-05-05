//
//  InitialViewSectionView.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 28.08.15.
//  Copyright © 2015 Anerma. All rights reserved.
//

import UIKit

/// One view of the initial view. It represents a section. Consists of subviews to name them correctly.
final class InitialViewSectionView: SelectableView {

    @IBOutlet weak var gradientView: GradientView! {
        didSet {
            viewToBeHighlighted = gradientView
        }
    }
    @IBOutlet weak var textLabel: UILabel!
    
    /// NSLayoutConstraint attached to the center. Set by the ViewController to specify position of this view.
    var constraintVerticalToCenter : NSLayoutConstraint?
    /// NSLayoutConstraint attached to the center. Set by the ViewController to specify position of this view.
    var constraintHorizontalToCenter : NSLayoutConstraint?
    
        /// Index of the section that is represented by this view.
    var indexOfView : Int! {
        didSet {
            updateUI()
        }
    }
    
    private var grayOverlayView : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.colorFromHex(0xA7A5A5).colorWithAlphaComponent(0.8)
        
        return view
    }()
    
    private(set) var sectionValues : SectionValues!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientView.cornerRadius = frame.width / 2
        
//        gradientView.layer.shadowOffset = CGSizeMake(5, 2)
        layer.shadowRadius = 4;
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSizeMake(1, 4)
        layer.shadowColor = UIColor.blackColor().CGColor
        let path = UIBezierPath()
        path.addArcWithCenter(gradientView.center, radius: CGRectGetWidth(gradientView.frame) / 2, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        layer.shadowPath = path.CGPath
        
        grayOverlayView.frame = gradientView.bounds
        gradientView.addSubview(grayOverlayView)
    }
    
    func animateToColorWithDuration(duration: Double, delay: Double) {
        UIView.animateWithDuration(duration, delay: delay, options: [], animations: { 
            self.grayOverlayView.alpha = 0
            }) { (_) in
                self.grayOverlayView.removeFromSuperview()
        }
    }
    
    private func updateUI() {
        guard indexOfView >= 0 && indexOfView < 7 else {return}
        
        sectionValues = SectionValuesStore.sectionValuesForViewAtIndex(indexOfView)
        
        gradientView.startColor = sectionValues.gradientStartColor
        gradientView.endColor = sectionValues.gradientEndColor
        textLabel.text = sectionValues.sectionTitle
        

    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
