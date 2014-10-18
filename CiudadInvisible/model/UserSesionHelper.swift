//
//  UserSesionHelper.swift
//  CiudadInvisible
//
//  Created by Mathias on 30/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class UserSesionHelper: NSObject {
   
    // MARK: Properties
    var hasUserLogued = false
    var userLogued: User! = nil
    
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
    
    required override init() {
        
    }
    
    // MARK: Publics
    func loadInformation(completion: (success: Bool) -> ()) {
        // Carga toda la información referente al usuario logueado
        var defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let userId = defaults.integerForKey("user_logued")
        if userId != 0 {
            RestApiHelper.sharedInstance().loadUserInformation(userId, completion: { (success) -> () in
                completion(success: success)
            })
        } else {
            completion(success: false)
        }
        
        
    }
    
    func getUserLogued() -> User {
        return self.userLogued
    }
    
    func logout() {
        
        self.hasUserLogued = false
        self.userLogued = nil
        
        var defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("user_logued")
    }
    
    func saveInDeviceUserLogued(responseObject: AnyObject!) {
        
        var userJson = JSONValue(responseObject)
        println(userJson)
        var user = User()
        user.id = userJson["id"].integer
        user.first_name = userJson["first_name"].string
        user.last_name = userJson["last_name"].string
        user.username = userJson["username"].string
        user.email = userJson["email"].string
        user.facebook_id = userJson["facebook_id"].string
        
        // Cambia el valor de la variable
        self.hasUserLogued = true
        self.userLogued = user
        
        // Guarda en el dispositivo
        var defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(user.id, forKey: "user_logued")
        defaults.synchronize()
        
    }

}
