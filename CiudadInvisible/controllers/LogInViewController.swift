//
//  LogInViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 01/08/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, FBLoginViewDelegate {

    @IBOutlet var loginFacebookView: FBLoginView!
    @IBOutlet var siginButton: UIButton!
    
    let segueIdentifier = "LoginSegue"

    var swifter: Swifter
    // Default to using the iOS account framework for handling twitter auth
    let useACAccount = true
    
    // MARK: Lifecycle
    required init(coder aDecoder: NSCoder!) {
        self.swifter = Swifter(consumerKey: "xuAsNxSBgJGO2iAmmBsdfeQ6X", consumerSecret: "LLJ9aRjjCNdLLfcgOZkE0SxSFMFfsjQiJBMJkqTEPRVRUnDuJP")
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupFacebookLogin()
        
        self.configOutlets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Actions
    @IBAction func loginWithTwitter(sender: AnyObject) {

        if useACAccount {
            let accountStore = ACAccountStore()
            let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
            
            // Prompt the user for permission to their twitter account stored in the phone's settings
            accountStore.requestAccessToAccountsWithType(accountType, options: nil) {
                granted, error in
                
                if granted {
                    let twitterAccounts = accountStore.accountsWithAccountType(accountType)
                    
                    if twitterAccounts?.count == 0
                    {
                        println("There are no Twitter accounts configured. You can add or create a Twitter account in Settings.")
                    }
                    else {
                        let twitterAccount = twitterAccounts[0] as ACAccount
                        self.swifter = Swifter(account: twitterAccount)
                        self.fetchTwitterHomeStream()
                    }
                }
                else {
                    println(error.localizedDescription)
                }
            }
        }
        else {
            swifter.authorizeWithCallbackURL(NSURL(string: "swifter://success"), success: {
                accessToken, response in
                
                self.fetchTwitterHomeStream()
                
                },failure: { error in
                    println(error.localizedDescription)
                }

            )
        }

    }
    
    // MARK: Outlets
    func configOutlets() {
        
        // Boton de registro
        self.siginButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.siginButton.layer.borderWidth = 1.0
        
    }
    
    // MARK: Twitter
    func fetchTwitterHomeStream() {
        let failureHandler: ((NSError) -> Void) = {
            error in
            println(error.localizedDescription)
        }

        var userTwitterId: String! = ""
        
        self.swifter.getAccountSettingsWithSuccess({ (settings) -> Void in

            var userJson = JSONValue(settings)

            
            userTwitterId = userJson["screen_name"].string
            println(userTwitterId)
        }, failure: failureHandler)
        
        
        // Guarda el usuario
        var userLocal: User = User()
        userLocal.twitter_id = "elMath"
        userLocal.email = "mathcarignani@gmail.com"
        userLocal.first_name = "Mathias"
        userLocal.last_name = "Carignani"
        RestApiHelper.sharedInstance().loginTwitter(userLocal,
            completion: { (logued: Bool) in
                
                if logued {
                    println("Logueado con twitter")
                    self.performSegueWithIdentifier(self.segueIdentifier, sender: self)
                } else {
                    println("Error en logueo con twitter")
                }
        })

        
        
        /*
        self.swifter.getStatusesHomeTimelineWithCount(20, sinceID: nil, maxID: nil, trimUser: true, contributorDetails: false, includeEntities: true, success: {
            (statuses: [JSONValue]?) in
            
            // Usuario ingresado correctamente
            println(statuses)
            
            }, failure: failureHandler)
        */
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
