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

        self.configParse(application)
        
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
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        // Guarda el deviceToken en la instalacion actual y lo guarda en Parse
        var currentInstallation: PFInstallation = PFInstallation.currentInstallation()
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.saveInBackground()
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        println(error)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
    }
    
    // MARK: Aux
    func setMainController() {
        
        // Controla si hay un usuario logueado para ver a que controller va
        var defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()

        if (defaults.objectForKey("user_logued") != nil) {
            // Obtiene el usuario
            var userId = defaults.integerForKey("user_logued")
            println("Usuario loguedo: \(userId)")
            
            // Setea en verdadero que hay un usuario logueado
            UserSesionHelper.sharedInstance().configUserLogued(userId)
            
        } else {
            println("No hay usuario logueado")
        }
        
    }
    
    // MARK: - Parse
    func configParse(application: UIApplication) {
        // Inicia la aplicacion
        Parse.setApplicationId("s0cuxSztmN6KQ5IhHtfYe7fUi37Qi7IwEoBOkP4d", clientKey: "y8x1FPQqL8oLD1vjhcxWBUd2BJB1UwbbwnpfoKE2")
        
        // Configuracion de las push
        if application.respondsToSelector("registerUserNotificationSettings:") {
            // Running iOS 8
            let userNotificationTypes: UIUserNotificationType = (UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound)
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        } else {
            // Before iOS 8
            application.registerForRemoteNotificationTypes(UIRemoteNotificationType.Badge | UIRemoteNotificationType.Alert | UIRemoteNotificationType.Sound)
        }
        
    }

}

