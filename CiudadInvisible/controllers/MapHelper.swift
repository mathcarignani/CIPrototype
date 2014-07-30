//
//  MapHelper.swift
//  CiudadInvisible
//
//  Created by Mathias on 30/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit
import MapKit

class MapHelper: NSObject {
   
    // MARK: Aux
    class func centerMap(map: MKMapView, coordinate: CLLocationCoordinate2D, distance: CLLocationDistance) {
        // Crea la region y centra el mapa
        let region = MKCoordinateRegionMakeWithDistance(coordinate, distance, distance)
        map.setRegion(region, animated: true)
    }
    
    class func addAnotationToMap(map: MKMapView, coordinate: CLLocationCoordinate2D, title: NSString) {
        // Agrega el pin
        var annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        map.addAnnotation(annotation)
    }
    
}
