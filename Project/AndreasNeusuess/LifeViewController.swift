//
//  LifeViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 29.11.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit

/// ViewController that displays life section.
final class LifeViewController: UIViewController, SafariViewControllerPresentable {

    @IBOutlet weak var studyingTeaserLabel: UILabel! {
        didSet {
            studyingTeaserLabel.tag = 1
        }
    }
    @IBOutlet weak var hiwiTeaserLabel: UILabel! {
        didSet {
            hiwiTeaserLabel.tag = 2
        }
    }
    @IBOutlet weak var blogTeaserLabel: UILabel! {
        didSet {
            blogTeaserLabel.tag = 3
        }
    }
    @IBOutlet weak var designTeaserLabel: UILabel! {
        didSet {
            designTeaserLabel.tag = 4
        }
    }
    @IBOutlet weak var personalityTeaserLabel: UILabel! {
        didSet {
            personalityTeaserLabel.tag = 5
        }
    }
    
    @IBOutlet weak var studyingHeaderLabel: UILabel!
    @IBOutlet weak var hiwiHeaderLabel: UILabel!
    @IBOutlet weak var blogHeaderLabel: UILabel!
    @IBOutlet weak var designHeaderLabel: UILabel!
    @IBOutlet weak var personalityHeaderLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var studyTeaserGestureRecognizer : UITapGestureRecognizer!
    private var hiwiTeaserGestureRecognizer : UITapGestureRecognizer!
    private var blogTeaserGestureRecognizer : UITapGestureRecognizer!
    private var designTeaserGestureRecognizer : UITapGestureRecognizer!
    private var personalityTeaserGestureRecognizer : UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareGestureRecognizers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func prepareGestureRecognizers() {
        studyTeaserGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LifeViewController.userTappedOnTeaserLabelWithGestureRecognizer(_:)))
        hiwiTeaserGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LifeViewController.userTappedOnTeaserLabelWithGestureRecognizer(_:)))
        blogTeaserGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LifeViewController.userTappedOnTeaserLabelWithGestureRecognizer(_:)))
        designTeaserGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LifeViewController.userTappedOnTeaserLabelWithGestureRecognizer(_:)))
        personalityTeaserGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LifeViewController.userTappedOnTeaserLabelWithGestureRecognizer(_:)))
        
        studyingTeaserLabel.addGestureRecognizer(studyTeaserGestureRecognizer)
        hiwiTeaserLabel.addGestureRecognizer(hiwiTeaserGestureRecognizer)
        blogTeaserLabel.addGestureRecognizer(blogTeaserGestureRecognizer)
        designTeaserLabel.addGestureRecognizer(designTeaserGestureRecognizer)
        personalityTeaserLabel.addGestureRecognizer(personalityTeaserGestureRecognizer)
        
        studyingTeaserLabel.userInteractionEnabled = true
        hiwiTeaserLabel.userInteractionEnabled = true
        blogTeaserLabel.userInteractionEnabled = true
        designTeaserLabel.userInteractionEnabled = true
        personalityTeaserLabel.userInteractionEnabled = true
    }
    
    @IBAction func visitBlogButtonPressed(sender: AnyObject) {
        showSafariViewControllerWithURL(NSURL(string: "https://anerma.de/blog"))
    }

    /**
     Method used for handling GestureRecognizers tap on a header label. Then the ScrollView will scroll to this position.
     
     - parameter gestureRecognizer: UITapGestureRecognizer that fired
     */
    func userTappedOnTeaserLabelWithGestureRecognizer(gestureRecognizer: UITapGestureRecognizer) {
        guard gestureRecognizer.state == .Ended else {return}
        //sadly have to switch between tags because GestureRecognizers yan only have one view to be attached to and I don't know any better workaround 😕
        
        var viewToScrollTo: UIView?
        
        switch gestureRecognizer.view!.tag {
        case 1:
            viewToScrollTo = studyingHeaderLabel
        case 2:
            viewToScrollTo = hiwiHeaderLabel
        case 3:
            viewToScrollTo = blogHeaderLabel
        case 4:
            viewToScrollTo = designHeaderLabel
        case 5:
            viewToScrollTo = personalityHeaderLabel
        default: ()
        }
        
        guard let scrollingToView = viewToScrollTo else {return}
        
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        let rectToScrollTo = CGRectApplyAffineTransform(scrollingToView.frame, CGAffineTransformMakeTranslation(0, screenHeight/2))
        scrollView.scrollRectToVisible(rectToScrollTo, animated: true)
        
    }


}
