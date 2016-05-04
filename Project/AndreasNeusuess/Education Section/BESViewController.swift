//
//  BESViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 26.03.16.
//  Copyright © 2016 Anerma. All rights reserved.
//

import UIKit

/// ViewController that presents information about BES.
final class BESViewController: UIViewController {


    @IBOutlet weak var imageDescriptionVisualEffectView2: UIVisualEffectView! {
        didSet {
            imageDescriptionVisualEffectView2.layer.cornerRadius = 7
            imageDescriptionVisualEffectView2.layer.borderColor = UIColor.blackColor().colorWithAlphaComponent(0.4).CGColor
            imageDescriptionVisualEffectView2.layer.borderWidth = 1
            imageDescriptionVisualEffectView2.clipsToBounds = true
        }
    }
    @IBOutlet weak var imageDescriptionVisualEffectView3: UIVisualEffectView! {
        didSet {
            imageDescriptionVisualEffectView3.layer.cornerRadius = 7
            imageDescriptionVisualEffectView3.layer.borderColor = UIColor.blackColor().colorWithAlphaComponent(0.4).CGColor
            imageDescriptionVisualEffectView3.layer.borderWidth = 1
            imageDescriptionVisualEffectView3.clipsToBounds = true
        }
    }
    @IBOutlet weak var parallaxImageContainer1: ParallaxImageContainerView!
    @IBOutlet weak var parallaxImageContainer2: ParallaxImageContainerView!
    @IBOutlet weak var parallaxImageContainer3: ParallaxImageContainerView!
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    //Styling section values to pass to PicturePresentationCollectionViewController
    var sectionValues: SectionValues!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidLayoutSubviews() {
        updateParallaxContainerViews()
        super.viewDidLayoutSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowPicturePresentation" {
            guard let destination = segue.destinationViewController as? PicturePresentationCollectionViewController else {return}
            
            destination.dataToPresentInCell = picturePresentationData()
            destination.sectionValues = sectionValues
        }
    }
    
    private func picturePresentationData() -> [PicturePresentationCellData] {
        let data1 = PicturePresentationCellData(imageName: "AMT 3", description: "Finished electronics")
        let data2 = PicturePresentationCellData(imageName: "AMT 4", description: "Finished vehicle")
        let data3 = PicturePresentationCellData(imageName: "AMT 5", description: "Final rehersal before presentation starts")
        let data4 = PicturePresentationCellData(imageName: "AMT 6", description: "Presentation in front of examiner")
        let data5 = PicturePresentationCellData(imageName: "AMT 7", description: "Presentation in progress")
        let data6 = PicturePresentationCellData(imageName: "AMT 8", description: "After presentation, video stream of me and my teammate")
        let data7 = PicturePresentationCellData(imageName: "AMT 9", description: "Me presenting my project in front of international audience")
        let data8 = PicturePresentationCellData(imageName: "AMT 10", description: nil)
        let data9 = PicturePresentationCellData(imageName: "AMT 11", description: "I also was asked to speak in front of the next generation of students")
        
        return [data1, data2, data3, data4, data5, data6, data7, data8, data9]
    }

}

// MARK: - UIScrollViewDelegate 
extension BESViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateParallaxContainerViews()
    }
    private func updateParallaxContainerViews() {
        parallaxImageContainer1.updatePosition()
        parallaxImageContainer2.updatePosition()
        parallaxImageContainer3.updatePosition()
    }
}