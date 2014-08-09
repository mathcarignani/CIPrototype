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
    @IBOutlet var siginButton: UIButton
    
    let segueIdentifier = "LoginSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupFacebookLogin()
        
        self.configOutlets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Outlets
    func configOutlets() {
        
        // Boton de registro
        self.siginButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.siginButton.layer.borderWidth = 1.0
        
    }
    
    // MARK: Facebook
    func setupFacebookLogin() {
        self.loginFacebookView.delegate = self
        self.loginFacebookView.readPermissions = ["public_profile", "email"] // "user_friends"
    }

    // MARK: FBLoginViewDelegate
    // This method will be called when the user information has been fetched
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {

        // Crea el usuario para enviar a la API
        var userLocal: User = User()
        userLocal.facebook_id = user.objectID
        userLocal.email = user.objectForKey("email") as String
        userLocal.first_name = user.first_name
        userLocal.last_name = user.last_name
        RestApiHelper.sharedInstance().loginFacebook(userLocal,
            completion: { (logued: Bool) in
                
                if logued {
                    println("Logueado con facebook")
                    self.performSegueWithIdentifier(self.segueIdentifier, sender: self)
                } else {
                    println("Error en logueo con facebook")
                }
            })
    }

}
