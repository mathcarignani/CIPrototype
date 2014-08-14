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
    func getUserLogued() -> User {
        
        // Si el usuario no existe lo obtiene
        if self.userLogued == nil {
            
            var defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
            let userId = defaults.integerForKey("user_logued")
            
            RestApiHelper.sharedInstance().getUser(userId, completion: { (user: User) -> () in
                self.userLogued = user
            })
            
        }
        
        // PRUEBA
        self.userLogued = User()
        self.userLogued.first_name = "Mathias"
        self.userLogued.last_name = "Carignani"
        // PRUEBA
        
        return self.userLogued
    }
    
    func logout() {
        
        self.hasUserLogued = false
        self.userLogued = nil
        
        var defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("user_logued")
    }
    
    func configUserLogued(id: Int) {
        // Setea en verdadero la variable
        self.hasUserLogued = true
        
        // Obtiene el usuario de la api y lo guarda local
        
    }
    
    func saveInDeviceUserLogued(responseObject: AnyObject!) {
        
        var userJson = JSONValue(responseObject)
        var user = User()
        user.id = userJson["id"].integer
        
        // Cambia el valor de la variable
        self.hasUserLogued = true
        
        // Guarda en el dispositivo
        var defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(user.id, forKey: "user_logued")
        defaults.synchronize()
        
    }

}
