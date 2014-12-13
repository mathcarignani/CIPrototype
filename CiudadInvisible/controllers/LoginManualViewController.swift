//
//  LoginManualViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 05/08/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class LoginManualViewController: UIViewController {

    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    
    let segueIdentifier = "LoginSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func backToLoginMain(sender: AnyObject) {
        (self.parentViewController as LoginContainerViewController).changeToViewControllerIndex(0)
    }
    
    @IBAction func login(sender: AnyObject) {
        ProgressHUD.show("Please wait...")
        
        RestApiHelper.sharedInstance().loginManual(self.emailText.text,
            password: self.passwordText.text,
            completion: {(logued: Bool) in
                ProgressHUD.dismiss()
                if logued {
                    // Se logueo correctamente
                    self.parentViewController?.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    // Error al loguearse
                    self.showErrorMessage()
                }
            })
    }
    
    @IBAction func forgotPassword(sender: AnyObject) {
    }
    
    // MARK: Auxiliares
    func showErrorMessage() {
        println("Usuario y/o contrasena incorrecto.")
    }
}
