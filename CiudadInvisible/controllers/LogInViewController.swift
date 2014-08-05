//
//  LogInViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 01/08/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, FBLoginViewDelegate {

    @IBOutlet var loginFacebookView: FBLoginView
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupFacebookLogin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Facebook
    func setupFacebookLogin() {
        self.loginFacebookView.delegate = self
        self.loginFacebookView.readPermissions = ["public_profile", "email"] // "user_friends"
    }

    // MARK: FBLoginViewDelegate
    // This method will be called when the user information has been fetched
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        println(user)
        println(user.name)
        
        /*
        {
            email = "mathcarignani@gmail.com";
            "first_name" = Mathias;
            gender = male;
            id = 10203569806981983;
            "last_name" = Carignani;
            link = "https://www.facebook.com/app_scoped_user_id/10203569806981983/";
            locale = "es_LA";
            name = "Mathias Carignani";
            timezone = "-3";
            "updated_time" = "2014-02-09T19:29:28+0000";
            verified = 1;
        }
        */

    }

}
