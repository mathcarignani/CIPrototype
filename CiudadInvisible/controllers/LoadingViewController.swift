//
//  LoadingViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 17/10/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewDidAppear(animated: Bool) {
        // Cuando termina de cargar la información sigue a la siguiente pantalla
        UserSesionHelper.sharedInstance().loadInformation { (success) -> () in
            self.performSegueWithIdentifier("GoToHome", sender: self)
        }
    }

}
