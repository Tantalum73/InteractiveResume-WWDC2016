//
//  SkillsPresentationViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 11.09.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit

/// ViewController that shows different skills of mine. Subclass of SectionSuperViewController and responsible for managing its UICollectionView that is used to display the 'skill cards'.
final class SkillsPresentationViewController: SectionSuperViewController, UICollectionViewDelegate, UICollectionViewDataSource, SafariViewControllerPresentable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.numberOfPages = 6
            
            pageControl.pageIndicatorTintColor = sectionValues.tintColor
            pageControl.currentPageIndicatorTintColor = sectionValues.gradientEndColor.colorWithAlphaComponent(0.4)
            
            pageControl.addTarget(self, action: #selector(SkillsPresentationViewController.pageControlDidTouch), forControlEvents: .TouchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpCollectionView()
        view.backgroundColor = UIColor.clearColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLayoutSubviews() {
        calculateItemSize()
        super.viewDidLayoutSubviews()
    }
    
    //MARK: CollectionView Setup Methods

    
    private func setUpCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal
        
        
        
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        
        collectionView.setCollectionViewLayout(flowLayout, animated: false)
    }
    
    private func calculateItemSize() {
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let bounds = UIScreen.mainScreen().bounds
        let height = collectionView.frame.size.height - flowLayout.sectionInset.top - flowLayout.sectionInset.bottom - collectionView.contentInset.top - collectionView.contentInset.bottom - 25
        
        
        flowLayout.itemSize = CGSize(width: bounds.width, height: height)
    }
    
    //MARK: UICollectionView Data Source Methods
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let reuseIdentifier = "SkillsCell\(indexPath.row + 1)"
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        //make sure that we are talking about Cell4
        guard indexPath.row == 3, let cell4 = cell as? SkillsCollectionViewCell4 else {return}

        //Adding GestureRecognizer here, removing it if cell is not longer visible.
        cell4.addGestureRecognizerToTeaserImagesWithTarget(self, action: #selector(SkillsPresentationViewController.teaserTappedWithGestureRecognizer(_:)))
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        //make sure that we are talking about Cell4
        guard indexPath.row == 3, let cell4 = cell as? SkillsCollectionViewCell4 else {return}
        
        //Removing GestureRecognizer because the cell is no longer visible.
        cell4.removeGestureRecognizerFromTeaserImage()
    }
    
    //MARK: - Action Methods 
    /**
     Method that is called when the PageControl did receive a touch event. In this case, it automatically jumps to the tapped position but the system does not automatically update the scroll position of the CollectionView. This methods couples the touch mechanism to the CollectionView and makes it scroll.
     */
    func pageControlDidTouch() {
        let indexPath = NSIndexPath(forItem: pageControl.currentPage, inSection: 0)
        
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: true)
    }
    
    //MARK: - Teaser Tap Gesture Recognizer Target
    /**
     Method that is called when a tap in the SkillsCollectionViewCell4 on its imageViews happened. Then, a SafariViewController should be opened.
     
     - parameter recognizer: UIGestureRecognizer that fired.
     */
    func teaserTappedWithGestureRecognizer(recognizer: UIGestureRecognizer) {
        guard let tag = recognizer.view?.tag where recognizer.state == UIGestureRecognizerState.Recognized else {return}
        
        var url : NSURL?
        //Bad coupling again, see comments in SkillsCollectionViewCell4 😒
        switch tag {
        case 0:
            //ClubNews
            url = NSURL(string: "https://clubnews-app.de")
        case 1:
            //ClubNews Admin
            url = NSURL(string: "https://clubnews-app.de/club")
        case 2:
            //Blog
            url = NSURL(string: "https://anerma.de/blog")
        case 3:
            //TourTime
            url = NSURL(string: "https://anerma.de/TourTime")
        default:
            ()
        }
        showSafariViewControllerWithURL(url)
        
        
    }

}

// MARK: - UIScrollViewDelegate Methods
extension SkillsPresentationViewController {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        guard let visibleCells = collectionView.visibleCells() as? [SkillsCollectionViewCell] else{return}
        
        for cell in visibleCells {
            cell.scrollViewDidScroll(scrollView)
        }
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let fractionalPage = scrollView.contentOffset.x / pageWidth
        let actualPage = lroundf(Float(fractionalPage))
        if actualPage != pageControl.currentPage {
            //new page is becoming visible
            pageControl.currentPage = actualPage
        }
    }
}This lines will prevent compiling.

Please note the copyright and be so kind to play along. Please refrain from copying or modifying.

If you would like to use parts of the app, please contact me :)