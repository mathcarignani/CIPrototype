//
//  LoadingViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 17/10/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIScreen.mainScreen().bounds.height == 568.0 {
            // Es iphone 5/5s
            self.backgroundImage.image = UIImage(named: "splash.png")
        }
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
