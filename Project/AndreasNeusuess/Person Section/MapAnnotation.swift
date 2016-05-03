//
//  MapAnnotation.swift
//  ClubNews
//
//  Created by Simon Feistel on 26.01.15.
//  Copyright (c) 2015 Anerma. All rights reserved.
//

import UIKit
import MapKit

/// A MKAnnotation that is used by the MKMapView of the PersonViewController and maybe others.
final class MapAnnotation: NSObject, MKAnnotation  {
    
        /// Coordinate of the annotation.
    let coordinate: CLLocationCoordinate2D
        /// Title of the annotation.
    let title: String?
        /// Subtitle of the annotation.
    let subtitle: String?

    /**
     Init with given coordinate, title, subtitle.
     
     - parameter coordinate: Coordinate of the annotation.
     - parameter title:      Title of the callout view.
     - parameter subtitle:   Subtitle, obviously^^
     
     - returns: Instance of MapAnnotation
     */
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
   
    /**
     Builds MKAnnotationView derived from self, used to display a custom image instead of the standard needle.
     
     - returns: MKAnnotationView that is not the standard needle but a custom image.
     */
    func annotationView()->MKAnnotationView
    {
        let annotationView = MKAnnotationView(annotation: self, reuseIdentifier: "customAnnotation")
        
        annotationView.enabled = true
        annotationView.canShowCallout = true
        annotationView.image = UIImage(named: "Map Icon")
        
        return annotationView
    }
    
    
}
