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
    
    func name() -> String {
        return "\(self.first_name) \(self.last_name)"
    }
    
    func avatar() -> UIImage {
        return UIImage(named: "avatar.png")
    }
    
    /*
    t.string   "username"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "facebook_id"
    t.string   "twitter_id"
    t.string   "city"
    t.string   "country"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "login_type"
    */
    
}
