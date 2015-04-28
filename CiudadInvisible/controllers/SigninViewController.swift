//
//  SiginViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 08/08/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {
    
    // Outlets
    @IBOutlet var firstNameText: UITextField!
    @IBOutlet var lastNameText: UITextField!
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func close(sender: AnyObject) {
        (self.parentViewController as! LoginContainerViewController).changeToViewControllerIndex(0)
    }
    
    @IBAction func sigin(sender: AnyObject) {
        
        // Crea el nuevo usuario
        var user: User = User()
        user.first_name = self.firstNameText.text
        user.last_name = self.lastNameText.text
        user.email = self.emailText.text
        user.password = self.passwordText.text
        
        // Da de alta el usuario 
        RestApiHelper.sharedInstance().siginManual(user,
            completion: {(register: Bool) in
                if register {
                    println("Registrado")
                    self.parentViewController?.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    println("Error")
                }
            })
        
    }
    
}
