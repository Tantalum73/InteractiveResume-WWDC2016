//
//  PersonViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 01.09.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit
import MapKit

/// ViewController that displays the 'About Me' section. Inherits from SectionSuperViewController
final class PersonViewController: SectionSuperViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.layer.cornerRadius = 10.0
            mapView.delegate = self
        }
    }
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
        
    private let homeCoordinate = CLLocationCoordinate2DMake(51.1904794, 10.0530052)
    private var bouncyViewControllerForProfilePicture : BouncyViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpHeaderControllerWithNavigationController(navigationController!, labelThatBecomesTitleView: headerLabel, gradientView: gradientView)
        scrollView.delegate = self
        
        bouncyViewControllerForProfilePicture = BouncyViewController(bouncyView: profilePic, imageIsOnTop: true, maxScaleFactor: 1.3)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let annotation = MapAnnotation(coordinate: homeCoordinate, title: "My Home", subtitle: "")
        mapView.addAnnotation(annotation)
        adjustMapZoom()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func doneButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

//MARK: - UIScrollViewDelegate Methods
extension PersonViewController : UIScrollViewDelegate, BouncyViewControllersNeedsMethodsOfUIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        adjustMapZoom()
        fadingNavBarTitleController.updateTitleView(scrollView)
        
        bouncyViewControllerForProfilePicture.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        bouncyViewControllerForProfilePicture.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        bouncyViewControllerForProfilePicture.scrollViewWillBeginDragging(scrollView)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        bouncyViewControllerForProfilePicture.scrollViewDidEndDecelerating(scrollView)
    }
    
    
    private func adjustMapZoom() {

        let klimax = CGRectGetMidY(view.frame)
        let globalcenterOfMapView = mapView.convertPoint(CGPoint(x: CGRectGetMidX(mapView.bounds), y: CGRectGetMidY(mapView.bounds)), toView: nil).y
        
        
        let normalizedDifferenceBetweenKlimaxAndMapViewCenter : Double = Double(min(1, fabs(klimax / globalcenterOfMapView)))
        
//        print("nomalized distance: \(normalizedDifferenceBetweenKlimaxAndMapViewCenter)")
        
        let distance = 2000000 - ((2000000 - 10000) * normalizedDifferenceBetweenKlimaxAndMapViewCenter)
        let viewRegion = MKCoordinateRegionMakeWithDistance(homeCoordinate, distance, distance)
        let mapRegion = mapView.regionThatFits(viewRegion)
        mapView.setRegion(mapRegion, animated: false)
    }
    
    private func isWiderThanHeigh() -> Bool {
        let size = view.frame.size
        return size.width > size.height
    }

}

//MARK: - MKMapViewDelegate Methods
extension PersonViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if(annotation.coordinate.latitude == self.mapView.userLocation.coordinate.latitude && annotation.coordinate.longitude == self.mapView.userLocation.coordinate.longitude)
        {
            return nil
        }
        
        
        if let myAnnotation = annotation as? MapAnnotation {
            
            let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("customAnnotation") ?? myAnnotation.annotationView()
            
            annotationView.annotation = annotation
            
            
            return annotationView
        }
        
        return nil
        
    }
    
    
    /**
     Animate the drop in of newly added annotations.
     */
 
    func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
        
        for view  in views
        {
            let annotationView = view
            let annoRect = annotationView.frame
            annotationView.frame = CGRectOffset(annoRect, 0.0, -500.0)
            
            UIView.animateWithDuration(0.6, animations: { () -> Void in
                
                annotationView.frame = annoRect
            })
            
        }
    }

    This line will prevent compiling.
    
    Please note the copyright and be so kind to play along.
    
    If you would like to use parts of the app, please contact me :)
}