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
    var latitude: Double! = nil
    var longitude: Double! = nil
    var favorites_quantity: Int! = nil
    var userId: Int! = nil
    var comments: NSArray! = nil
    var author_avatar: NSString! = nil
    
    override init() {
        super.init()
    }
    
    func coordinate() -> CLLocationCoordinate2D {
        
        if (latitude != nil && longitude != nil) {
            let latitude = self.latitude as CLLocationDegrees
            let longitude = self.longitude as CLLocationDegrees
            
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            return CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }

    // MARK: Images sizes
    func imagesSmall() -> NSArray {
        
        var smallImages: NSMutableArray! = NSMutableArray()
        // Recorre las imagenes y sustituye el texto
        for auxImage : AnyObject in self.images {
            let smallImage: String = (auxImage as String).stringByReplacingOccurrencesOfString("original", withString: "small", options: NSStringCompareOptions.LiteralSearch, range: nil)
            smallImages.addObject(smallImage)
        }
        
        return smallImages
    }
    
    func imagesMedium() -> NSArray {
        
        var mediumImages: NSMutableArray! = NSMutableArray()
        // Recorre las imagenes y sustituye el texto
        for auxImage : AnyObject in self.images {
            let mediumImage: String = (auxImage as String).stringByReplacingOccurrencesOfString("original", withString: "medium", options: NSStringCompareOptions.LiteralSearch, range: nil)
            mediumImages.addObject(mediumImage)
        }
        
        return mediumImages
    }
    
    func imagesLarge() -> NSArray {
        
        var largeImages: NSMutableArray! = NSMutableArray()
        // Recorre las imagenes y sustituye el texto
        for auxImage : AnyObject in self.images {
            let largeImage: String = (auxImage as String).stringByReplacingOccurrencesOfString("original", withString: "large", options: NSStringCompareOptions.LiteralSearch, range: nil)
            largeImages.addObject(largeImage)
        }
        
        return largeImages
    }
}
