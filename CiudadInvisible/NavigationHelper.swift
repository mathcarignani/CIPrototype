//
//  NavigationHelper.swift
//  CiudadInvisible
//
//  Created by Mathias on 4/12/15.
//  Copyright (c) 2015 CiudadInvisible. All rights reserved.
//

import UIKit

class NavigationHelper: NSObject {
  
  var goToNew: Bool = false
  var postId: Int = 0
  
  // MARK: - Singleton
  class func sharedInstance() -> NavigationHelper! {
    struct Static {
      static var instance: NavigationHelper? = nil
      static var onceToken: dispatch_once_t = 0
    }
    dispatch_once(&Static.onceToken) {
      Static.instance = self()
    }
    return Static.instance!
  }
  
  required override init() {
    
  }

  
}
