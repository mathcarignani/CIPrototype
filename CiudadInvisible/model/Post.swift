//
//  Post.swift
//  CiudadInvisible
//
//  Created by Mathias on 10/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit
import MapKit

class Post: NSObject {
    
    var id : Int! = nil
    var title : String! = nil
    var author : String! = nil
    var descriptionText : String! = nil
    var date : NSDate! = nil
    var location : NSString! = nil
    var category : String! = nil
    var images : NSArray! = nil
    var url : String! = nil
    
    
    init() {
        super.init()
    }
    
    func coordinate() -> CLLocationCoordinate2D {
        
        // Elimina los exrremos que corresponden a {}
        let auxParsing = self.location.substringWithRange(NSRange(location: 1,length: (self.location.length - 2)))

        // Separa por el , el primer campo corresponde al latitude y el segundo a longitude
        var split : NSArray = auxParsing.componentsSeparatedByString(",")

        let latitude = split.objectAtIndex(0).doubleValue as CLLocationDegrees
        let longitude = split.objectAtIndex(1).doubleValue as CLLocationDegrees
 
        var coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        return coordinate
    }

}
