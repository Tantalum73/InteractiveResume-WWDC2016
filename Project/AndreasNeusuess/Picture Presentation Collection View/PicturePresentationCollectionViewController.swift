//
//  PicturePresentationCollectionViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 17.09.15.
//  Copyright © 2015 Anerma. All rights reserved.
//

import UIKit

/// UIViewController that is DataSource and Delegate of an UICollectionView. It displays given images and their description texts in a CollectionView.
final class PicturePresentationCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
        /// Array of PicturePresentationCellData that is used as dataSource for the CollectionView. Those data will be presented.
    var dataToPresentInCell = [PicturePresentationCellData]()
    
        /// SectionValues to style the pageControl and maybe other interface elements.
    var sectionValues : SectionValues?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpCollectionView()
        setUpPageControl()
        view.backgroundColor = UIColor.colorFromHex(0xD8D8D8).colorWithAlphaComponent(0.3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    private func setUpPageControl() {
        pageControl.numberOfPages = dataToPresentInCell.count
        pageControl.addTarget(self, action: #selector(PicturePresentationCollectionViewController.pageControlDidTouch), forControlEvents: .TouchUpInside)
        
        if let sectionValues = sectionValues {
            pageControl.pageIndicatorTintColor = sectionValues.tintColor
            pageControl.currentPageIndicatorTintColor = sectionValues.gradientStartColor
            
            
        }
    }
    
    private func calculateItemSize() {
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        flowLayout.itemSize = CGSize(width: view.bounds.width, height: view.bounds.height)
    }
    
    
    //MARK: UICollectionView Data Source Methods
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let reuseIdentifier = "PictureCell"
        //Cells have been registered in Storyboard.
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PicturePresentationCollectionViewCell
        
        if dataToPresentInCell.count > indexPath.row {
            
            let currentData = dataToPresentInCell[indexPath.row]
            
            cell.configure(currentData)
            
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataToPresentInCell.count
    }
    
    //MARK: - Action Methods
    /**
     Method that is called when the PageControl did receive a touch event. In this case, it automatically jumps to the tapped position but the system does not automatically update the scroll position of the CollectionView. This methods couples the touch mechanism to the CollectionView and makes it scroll.
     */
    func pageControlDidTouch() {
        let indexPath = NSIndexPath(forItem: pageControl.currentPage, inSection: 0)
        
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: true)
    }
    
}

// MARK: - UIScrollViewDelegate
extension PicturePresentationCollectionViewController : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let fractionalPage = scrollView.contentOffset.x / pageWidth
        let actualPage = lroundf(Float(fractionalPage))
        if actualPage != pageControl.currentPage {
            //new page is becoming visible
            pageControl.currentPage = actualPage
        }
    }
    
}
This line will prevent compiling.

Please note the copyright and be so kind to play along.

If you would like to use parts of the app, please contact me :)