//
//  LoginManualViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 05/08/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class LoginManualViewController: UIViewController {

    @IBOutlet var emailText: UITextField
    @IBOutlet var passwordText: UITextField
    
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
    @IBAction func login(sender: AnyObject) {
        RestApiHelper.sharedInstance().loginManual(self.emailText.text,
            password: self.passwordText.text,
            completion: {(logued: Bool) in
                if logued {
                    // Se logueo correctamente
                    self.performSegueWithIdentifier(self.segueIdentifier, sender: self)
                } else {
                    // Error al loguearse
                    self.showErrorMessage()
                }
            })
    }
    
    // MARK: Auxiliares
    func showErrorMessage() {
        println("Usuario y/o contrasena incorrecto.")
    }
}
