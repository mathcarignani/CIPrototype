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
    
    // Notification
    var notificationPayload = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? NSDictionary;
    if notificationPayload != nil {
      self.processNotificationPayload(notificationPayload!)
    }
    
    // Configuracion del color para la animacion inicial
//    self.window!.backgroundColor = UIColor(red: 197/255.0, green: 73/255.0, blue: 73/255.0, alpha: 1.0)
    
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
    RestApiHelper.sharedInstance().associateDeviceToken(currentInstallation.deviceToken)
  }
  
  func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
    println(error)
  }
  
  func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    PFPush.handlePush(userInfo)
  }
  
  // MARK: - Parse
  func configParse(application: UIApplication) {
    // Inicia la aplicacion
    Parse.setApplicationId("JV9KTqeAA1skH0ZiUE8PSzl7PwmnKptuumpj9pqZ", clientKey: "h51gOCAiGHy4i3ZGCDXWciLyhLc1C6ZMSEZjQV1Q")
    
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
  
  // MARK: - Notifications
  func processNotificationPayload(notification: NSDictionary) {
    println("------------- PAYLOAD -------------")
//    var payload = notification.objectForKey("payload") as NSDictionary
//    println(payload)
//    println(payload.objectForKey("type"))
//    if (payload["type"]!.isEqualToString("Comment")) {
//      println("Comment")
//    } else if (payload["type"]!.isEqualToString("Favorite")) {
//      println("Favorite")
//    } else if (payload["type"]!.isEqualToString("Following")) {
//      println("Following")
//    } else if (payload["type"]!.isEqualToString("Draft")) {
//      println("Draft")
//    }
    NavigationHelper.sharedInstance().postId = 2
    println("------------- PAYLOAD -------------")
  }
  
}

