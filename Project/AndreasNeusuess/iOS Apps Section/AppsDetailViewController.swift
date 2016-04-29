//
//  AppsDetailViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 20.09.15.
//  Copyright © 2015 Anerma. All rights reserved.
//

import UIKit
import StoreKit

/// ViewController that unites methods which are used by TourTime- and ClubNewsIntoViewController.
class AppsDetailViewController: SectionSuperViewController, SafariViewControllerPresentable {

        /// ImageView for the app.
    @IBOutlet weak var appIcon: UIImageView!
        /// Main ScrollView.
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var bouncyViewControllerForAppIcon : BouncyViewController!
    private var productViewController = SKStoreProductViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bouncyViewControllerForAppIcon = BouncyViewController(bouncyView: appIcon)
        scrollView.delegate = bouncyViewControllerForAppIcon
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     Opens the AppStore in SKStoreProductViewController for a given app.
     
     - parameter type: Type of the app whose AppStore page shall be opened.
     */
    func openAppStoreForApp(type: TypeOfApp) {
        let iTunesID : String
        
        switch type {
        case .TourTime:
            iTunesID =  "848979893"
        case .ClubNews:
            iTunesID = "997430682"
        }
        
        productViewController.loadProductWithParameters([SKStoreProductParameterITunesItemIdentifier : iTunesID], completionBlock: nil)
        
        presentViewController(productViewController, animated: true, completion: nil)
    }
    
    /**
     Opens SafariViewController to present the apps website. Uses SafariViewControllerPresentable.
     
     - parameter type: Type of the app whose AppStore page shall be opened.
     */
    func openWebsiteForApp(type: TypeOfApp) {
        let url : NSURL
        
        switch type {
        case .TourTime:
            url =  NSURL(string: "https://anerma.de/TourTime")!
        case .ClubNews:
            url = NSURL(string: "https://clubnews-app.de")!
        }
        showSafariViewControllerWithURL(url)
        
    }


}

//MARK: SKStoreProductViewControllerDelegate Methods
extension AppsDetailViewController : SKStoreProductViewControllerDelegate {
    
    func productViewControllerDidFinish(viewController: SKStoreProductViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
