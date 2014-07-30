//
//  UserSesionHelper.swift
//  CiudadInvisible
//
//  Created by Mathias on 30/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class UserSesionHelper: NSObject {
   
    // MARK: Singleton
    class func sharedInstance() -> UserSesionHelper! {
        struct Static {
            static var instance: UserSesionHelper? = nil
            static var onceToken: dispatch_once_t = 0
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = self()
        }
        return Static.instance!
    }
    
    @required init() {
        
    }
    
    // MARK: Publics
    func getUserLogued() -> String {
        return "Mathias Carignani"
    }
}
