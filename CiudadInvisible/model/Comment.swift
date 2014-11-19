//
//  Comment.swift
//  CiudadInvisible
//
//  Created by Mathias on 8/11/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class Comment: NSObject {
    var id: Int! = nil
    var text: String! = nil
    var first_name: String! = nil
    var last_name: String! = nil
    var username: String! = nil
    var avatar: String! = nil
    var post: Post! = nil
}