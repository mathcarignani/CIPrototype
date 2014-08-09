//
//  AppDelegate.swift
//  CiudadInvisible
//
//  Created by Mathias on 27/06/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        // Override point for customization after application launch.
        
        // Configuracion del color para la animacion inicial
        self.window!.backgroundColor = UIColor(red: 197/255.0, green: 73/255.0, blue: 73/255.0, alpha: 1.0)
        
        self.setMainController()

        return true
    }

    func application(application: UIApplication!, openURL url: NSURL!, sourceApplication: String!, annotation: AnyObject!) -> Bool {
        
        // Call FBAppCalls handleOpenURL to handle Facebook app responses
        var wasHandled = FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
        
        return wasHandled
    }
    
    // MARK: Aux
    func setMainController() {
        
        // Controla si hay un usuario logueado para ver a que controller va
        var defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()

        if defaults.objectForKey("user_logued") {
            // Obtiene el usuario
            var userId = defaults.integerForKey("user_logued")
            println("Usuario loguedo: \(userId)")
            
            // Setea en verdadero que hay un usuario logueado
            UserSesionHelper.sharedInstance().configUserLogued(userId)
            
        } else {
            println("No hay usuario logueado")
        }
        
    }

}

