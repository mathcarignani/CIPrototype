//
//  PostAnnotation.swift
//  CiudadInvisible
//
//  Created by Mathias on 29/08/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit
import MapKit

class PostAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String
    var subtitle: String
    var post: Post! = nil
    
    override init() {
        self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0);
        self.title = "";
        self.subtitle = "";
    }
    
}
