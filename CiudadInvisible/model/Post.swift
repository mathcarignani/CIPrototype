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
    var location : String! = nil
    var category : String! = nil
    var images : NSArray! = nil
    var url : String! = nil
    
    
    init() {
        super.init()
    }

}
