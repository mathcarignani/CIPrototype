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
    
    
    override init() {
        super.init()
    }
    
    func coordinate() -> CLLocationCoordinate2D {
        
        if self.location != nil && self.location.length > 0 {
        
            // Elimina los exrremos que corresponden a {}
            let auxParsing = self.location.substringWithRange(NSRange(location: 1,length: (self.location.length - 2)))

            // Separa por el , el primer campo corresponde al latitude y el segundo a longitude
            var split : NSArray = auxParsing.componentsSeparatedByString(",")

            let latitude = split.objectAtIndex(0).doubleValue as CLLocationDegrees
            let longitude = split.objectAtIndex(1).doubleValue as CLLocationDegrees
     
            var coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            return coordinate
        } else {
            return CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }

    // MARK: Images sizes
    func imagesSmall() -> NSArray {
        
        var smallImages: Array = []
        // Recorre las imagenes y sustituye el texto
        for auxImage : AnyObject in self.images {
            let smallImage: String = (auxImage as String).stringByReplacingOccurrencesOfString("original", withString: "small", options: NSStringCompareOptions.LiteralSearch, range: nil)
            smallImages.append(smallImage)
        }
        
        return smallImages
    }
    
    func imagesMedium() -> NSArray {
        
        var mediumImages: Array = []
        // Recorre las imagenes y sustituye el texto
        for auxImage : AnyObject in self.images {
            let mediumImage: String = (auxImage as String).stringByReplacingOccurrencesOfString("original", withString: "medium", options: NSStringCompareOptions.LiteralSearch, range: nil)
            mediumImages.append(mediumImage)
        }
        
        return mediumImages
    }
    
    func imagesLarge() -> NSArray {
        
        var largeImages: Array = []
        // Recorre las imagenes y sustituye el texto
        for auxImage : AnyObject in self.images {
            let largeImage: String = (auxImage as String).stringByReplacingOccurrencesOfString("original", withString: "large", options: NSStringCompareOptions.LiteralSearch, range: nil)
            largeImages.append(largeImage)
        }
        
        return largeImages
    }
}
