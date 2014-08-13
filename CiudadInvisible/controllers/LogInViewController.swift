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
        
        var accountStore = ACAccountStore()
        var twitterType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(twitterType, options: nil) {
            granted, error in
            
            if granted {
                let twitterAccounts = accountStore.accountsWithAccountType(twitterType)
                
                if twitterAccounts {
                    if twitterAccounts.count == 0 {
                        println("There are no Twitter accounts configured. You can add or create a Twitter account in Settings.")
                    }
                    else {
                        let twitterAccount = twitterAccounts[0] as ACAccount
                        
                        println(twitterAccount)
                    }
                }
                else {
                    println("There are no Twitter accounts configured. You can add or create a Twitter account in Settings.")
                }
            }
        }
        /*
        ACAccountStore *store = [[ACAccountStore alloc] init];
        ACAccountType *twitterType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        [store requestAccessToAccountsWithType:twitterType withCompletionHandler:^(BOOL granted, NSError *error) {
        if(granted) {
        // Remember that twitterType was instantiated above
        NSArray *twitterAccounts = [store accountsWithAccountType:twitterType];
        
        // If there are no accounts, we need to pop up an alert
        if(twitterAccounts == nil || [twitterAccounts count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Twitter Accounts"
        message:@"There are no Twitter accounts configured. You can add or create a Twitter account in Settings."
        delegate:nil
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
        [alert show];
        } else {
        //Get the first account in the array
        ACAccount *twitterAccount = [twitterAccounts objectAtIndex:0];
        //Save the used SocialAccountType so it can be retrieved the next time the app is started.
        [[NSUserDefaults standardUserDefaults] setInteger:SocialAccountTypeTwitter forKey:kSocialAccountTypeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //Call the completion handler so the calling object can retrieve the twitter account.
        completionHandler(twitterAccount);
        }
        }
        */
        
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
