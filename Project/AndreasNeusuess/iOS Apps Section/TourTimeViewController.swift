//
//  TourTimeViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 20.09.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit

/// ViewController that shows information about TourTime. Subclass of AppsDetailViewController.
final class TourTimeViewController: AppsDetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowPicturePresentation" {
            guard let picturePresenter = segue.destinationViewController as? PicturePresentationCollectionViewController else{return}
            
            picturePresenter.dataToPresentInCell = picturePresentationData()
            
            picturePresenter.sectionValues = sectionValues
            
        }
    }

    //MARK: Button Action Methods
    @IBAction func appStoreButtonPressed(sender: AnyObject) {
        openAppStoreForApp(.TourTime)
    }
    @IBAction func websiteButtonPressed(sender: AnyObject) {
        openWebsiteForApp(.TourTime)
    }
    
    private func picturePresentationData() -> [PicturePresentationCellData] {
        let data1 = PicturePresentationCellData(imageName: "TourTime 1", description: "Overview of your tours")
        let data2 = PicturePresentationCellData(imageName: "TourTime 2", description: "Map showing start & destination")
        let data4 = PicturePresentationCellData(imageName: "TourTime 4", description: "Flyer I printed")
        let data5 = PicturePresentationCellData(imageName: "TourTime 5", description: "Cracked top 100 (navigation) in Austria 🎉")
        
        return [data1, data2, data4, data5]
    }

}

// MARK: - TTITakeAlongTransitionProtocolForPresented
extension TourTimeViewController : TTITakeAlongTransitionProtocolForPresented {
    func takeAlongDataWithPopulatedFinalFramesForTakeAlongData(takeAlongDataToPopulate: TTITakeAlongData!) {
        takeAlongDataToPopulate.finalView = appIcon
    }
}