//
//  EducationViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 05.09.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit

/// ViewController that presents the education section.
final class EducationViewController: SectionSuperViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var gradientView: GradientView!
    
    @IBOutlet weak var outlinedLabelView: OutlinedLabelView! {
        didSet {
            outlinedLabelView.pathOfLabel = PathStore.BESPath.CGPath
        }
    }
    
    @IBOutlet weak var parallaxImageViewContainer1: ParallaxImageContainerView!
    @IBOutlet weak var parallaxImageViewContainer2: ParallaxImageContainerView!
    @IBOutlet weak var parallaxImageViewContainer3: ParallaxImageContainerView!
    
    @IBOutlet weak var heightOfParallaxImageViewContainer1: NSLayoutConstraint!
    @IBOutlet weak var heightOfParallaxImageViewContainer2: NSLayoutConstraint!
    @IBOutlet weak var heightOfParallaxImageViewContainer3: NSLayoutConstraint!
    
    
    @IBOutlet weak var seperatedView1: UIView! {
        didSet {
            self.addSeperatedViewWithProgress(0.3, title:"Grundschule", toView: seperatedView1)
        }
    }
    @IBOutlet weak var seperatedView2: UIView! {
        didSet {
            self.addSeperatedViewWithProgress(0.5, title:"Oberstufe", toView: seperatedView2)
        }
    }
    @IBOutlet weak var seperatedView3: UIView! {
        didSet {
            self.addSeperatedViewWithProgress(0.8, title:"University", toView: seperatedView3)
        }
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.setUpHeaderControllerWithNavigationController(navigationController!, labelThatBecomesTitleView: headerLabel, gradientView: gradientView)
        addTapGestureRecognizerToImageViews()
        
        scrollView.delegate = self
        
    }

    override func viewDidLayoutSubviews() {
        updateParallaxContainerViews()
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func addTapGestureRecognizerToImageViews() {
        for view in [parallaxImageViewContainer1, parallaxImageViewContainer2, parallaxImageViewContainer3] {
            let gr = UITapGestureRecognizer(target: self, action: #selector(EducationViewController.gestureTappedOnViewWithRecognizer(_:)))
            
            view.addGestureRecognizer(gr)
        }
    }
    /**
     Method that handles action of UITapGestureRecognizer. It will open or close attached views of type ParallaxImageContainerView
     
     - parameter gr: The UITapGestureRecognizer that has fired.
     */
    func gestureTappedOnViewWithRecognizer(gr: UITapGestureRecognizer) {
        if gr.state == UIGestureRecognizerState.Recognized, let selectedView = gr.view as? ParallaxImageContainerView {
            
            let updatedConstraint : NSLayoutConstraint?
            if selectedView == parallaxImageViewContainer1 {
                updatedConstraint = heightOfParallaxImageViewContainer1
            }
            else if selectedView == parallaxImageViewContainer2 {
                updatedConstraint = heightOfParallaxImageViewContainer2
            }
            else if selectedView == parallaxImageViewContainer3 {
                updatedConstraint = heightOfParallaxImageViewContainer3
            }
            else {
                updatedConstraint = NSLayoutConstraint()
            }
            
            UIView.animateWithDuration(0.3, delay: 0, options: [UIViewAnimationOptions.AllowAnimatedContent, UIViewAnimationOptions.AllowUserInteraction, UIViewAnimationOptions.CurveEaseOut], animations: { () -> Void in
                
                updatedConstraint?.constant = selectedView.isExpanded ? 180 : 300
                selectedView.layoutIfNeeded()
                self.view.layoutIfNeeded()
                
                self.updateParallaxContainerViews()
                
                }, completion: { (finished) -> Void in
                    selectedView.isExpanded = !selectedView.isExpanded
                    self.view.layoutIfNeeded()
            })
        }
    }
    private func addSeperatedViewWithProgress(progress:Double, title:String, toView: UIView) {
    
        let seperatedView = NSBundle.mainBundle().loadNibNamed("SeperatedView", owner: self, options: nil).first as! SeperatedView
    
        seperatedView.progress = progress
        seperatedView.colorOfLeftPart = UIColor.colorFromHex(0xFF9000)
        seperatedView.colorOfRightPart = UIColor.colorFromHex(0xFD7215)
        
        seperatedView.title = title
        
        toView.addSubview(seperatedView)
        seperatedView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["seperatedView":seperatedView]
        
        toView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[seperatedView]-0-|", options: [], metrics: nil, views: views))
        toView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[seperatedView]-0-|", options: [], metrics: nil, views: views))
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowBESViewController" {
            guard let destination = segue.destinationViewController as? BESViewController else {return}
            
            destination.sectionValues = sectionValues
        }
    }


}

// MARK: - UIScrollViewDelegate Methods
extension EducationViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        fadingNavBarTitleController.updateTitleView(scrollView)
        updateParallaxContainerViews()
        updateOutlinesLabelView()
    }
    
    private func updateParallaxContainerViews() {
        parallaxImageViewContainer1.updatePosition()
        parallaxImageViewContainer2.updatePosition()
        parallaxImageViewContainer3.updatePosition()
    }
    
    private func updateOutlinesLabelView() {
        let globalOriginOfOutlinedView = outlinedLabelView.convertPoint(outlinedLabelView.bounds.origin, toView:nil)
//        print(globalOriginOfOutlinedView.y)
        
        let klimax = CGRectGetMidY(UIScreen.mainScreen().bounds) + UIScreen.mainScreen().bounds.size.height / 4
        
        let normalizedDifferenceBetweenKlimaxAndOrigin : CGFloat = CGFloat(min(1, fabs(klimax / globalOriginOfOutlinedView.y)))
//        print(normalizedDifferenceBetweenKlimaxAndOrigin)
    
        outlinedLabelView.progressOfStroke = normalizedDifferenceBetweenKlimaxAndOrigin
    }
}