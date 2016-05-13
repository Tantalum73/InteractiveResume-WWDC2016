//
//  ClubNewsInfoViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 17.09.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit

/// ViewController that shows information about ClubNews. Subclass of AppsDetailViewController.
final class ClubNewsInfoViewController: AppsDetailViewController {

    @IBOutlet weak var rightSpotlightContainerView: UIView! {
        didSet {
            rightSpotlightContainerView.transform = CGAffineTransformRotate(rightSpotlightContainerView.transform, CGFloat(M_PI_4))
            rightSpotlightContainerView.userInteractionEnabled = false
        }
    }
    @IBOutlet weak var leftSpotlightContainerView: UIView! {
        didSet {
            leftSpotlightContainerView.transform = CGAffineTransformRotate(leftSpotlightContainerView.transform, -CGFloat(M_PI_4))
            leftSpotlightContainerView.userInteractionEnabled = false
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateSpotlights()
    }
    
    private func animateSpotlights() {
        let rotationRight = CGAffineTransformRotate(rightSpotlightContainerView.transform, -CGFloat(M_PI_2))
        let rotationLeft = CGAffineTransformRotate(leftSpotlightContainerView.transform, CGFloat(M_PI_2))
        
        UIView.animateWithDuration(3.5, delay: 0, options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.CurveEaseInOut,UIViewAnimationOptions.Repeat, .BeginFromCurrentState], animations: { () -> Void in
            
            self.rightSpotlightContainerView.transform = rotationRight
            
            }) { (_) -> Void in
                
        }
        UIView.animateWithDuration(4.5, delay: 0.7, options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.CurveEaseInOut,UIViewAnimationOptions.Repeat, .BeginFromCurrentState], animations: { () -> Void in
            
            self.leftSpotlightContainerView.transform = rotationLeft
            
            }) { (_) -> Void in
                
        }
    }

    //MARK: Navigation & Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowPicturePresentation" {
            guard let picturePresenter = segue.destinationViewController as? PicturePresentationCollectionViewController else{return}
            
            picturePresenter.dataToPresentInCell = picturePresentationData()

                picturePresenter.sectionValues = sectionValues
            
        }
    }

    //MARK: Button Action Methods
    @IBAction func appStoreButtonPressed(sender: AnyObject) {
        openAppStoreForApp(.ClubNews)
    }
    
    @IBAction func websiteButtonPressed(sender: AnyObject) {
        openWebsiteForApp(.ClubNews)
    }
    
    private func picturePresentationData() -> [PicturePresentationCellData] {
        let data1 = PicturePresentationCellData(imageName: "ClubNews 1", description: "Overview of upcoming week")
        let data2 = PicturePresentationCellData(imageName: "ClubNews 2", description: "Club description page")
        let data3 = PicturePresentationCellData(imageName: "ClubNews 3", description: "Clubs in your surrounding")
        let data3_5 = PicturePresentationCellData(imageName: "ClubNews 3_5", description: "Coding our website")
        let data4 = PicturePresentationCellData(imageName: "ClubNews 4", description: "Composing AppStore preview video")
        let data5 = PicturePresentationCellData(imageName: "ClubNews 5", description: "Merchandise shirts & cups")
        let data6 = PicturePresentationCellData(imageName: "ClubNews 6", description: nil)
        let data7 = PicturePresentationCellData(imageName: "ClubNews 7", description: "Celebrating and promoting 🎉")
        let data8 = PicturePresentationCellData(imageName: "ClubNews 8", description: "Celebrating 💃🏼")
        
        return [data1, data2, data3, data3_5, data4, data5, data6, data7, data8]
    }

}

// MARK: - TTITakeAlongTransitionProtocolForPresented
extension ClubNewsInfoViewController : TTITakeAlongTransitionProtocolForPresented {
    func takeAlongDataWithPopulatedFinalFramesForTakeAlongData(takeAlongDataToPopulate: TTITakeAlongData!) {
        takeAlongDataToPopulate.finalView = appIcon
    }
}