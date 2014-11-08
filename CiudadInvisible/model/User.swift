//
//  User.swift
//  CiudadInvisible
//
//  Created by Mathias on 05/08/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class User: NSObject {
   
    var id: Int! = nil
    var username: String! = nil
    var email: String! = nil
    var first_name: String! = nil
    var last_name: String! = nil
    var facebook_id: String! = nil
    var twitter_id: String! = nil
    var password: String! = nil
    var city: String! = nil
    var country: String! = nil
    var url_avatar: String! = nil
    var bio: String! = nil
    var followers_quantity: Int! = nil
    var followed_quantity: Int! = nil
    
    func name() -> String {
        return "\(self.first_name) \(self.last_name)"
    }
    
    func avatar() -> UIImage {
        var image = UIImage(named: "avatar.png")
        return image
    }
    
}
