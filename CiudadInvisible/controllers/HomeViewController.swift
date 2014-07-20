//
//  HomeViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 20/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var capturarImage: UIImageView
    @IBOutlet var capturarLabel: UILabel
    
    @IBOutlet var explorarImage: UIImageView
    @IBOutlet var explorarLabel: UILabel
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        
        // Obtiene el punto tocado y si pertenece a la zona del generar
        let point = touches.anyObject().locationInView(self.view)
        let generar = point.y < self.view.frame.size.height / 2
        
        // Anima las imagenes y textos dependiendo de donde haya seleccionado
        if generar {
            UIView.animateWithDuration(0.2, animations: {
                self.capturarImage.transform = CGAffineTransformMakeScale(1.1, 1.1)
                self.capturarLabel.transform = CGAffineTransformMakeScale(1.1, 1.1)
                self.explorarImage.transform = CGAffineTransformMakeScale(0.9, 0.9)
                self.explorarLabel.transform = CGAffineTransformMakeScale(0.9, 0.9)
                self.explorarImage.alpha = 0.5
                self.explorarLabel.alpha = 0.5
                })
        } else {
            UIView.animateWithDuration(0.2, animations: {
                self.capturarImage.transform = CGAffineTransformMakeScale(0.9, 0.9)
                self.capturarLabel.transform = CGAffineTransformMakeScale(0.9, 0.9)
                self.explorarImage.transform = CGAffineTransformMakeScale(1.1, 1.1)
                self.explorarLabel.transform = CGAffineTransformMakeScale(1.1, 1.1)
                self.capturarImage.alpha = 0.5
                self.capturarLabel.alpha = 0.5
                })
        }
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
    
        // Obtiene el punto tocado y si pertenece a la zona del generar
        let point = touches.anyObject().locationInView(self.view)
        let generar = point.y < self.view.frame.size.height / 2
        
        // Vuelve las transformaciones a la normalidad
        UIView.animateWithDuration(0.2, animations: {
            self.capturarImage.transform = CGAffineTransformIdentity
            self.capturarLabel.transform = CGAffineTransformIdentity
            self.explorarImage.transform = CGAffineTransformIdentity
            self.explorarLabel.transform = CGAffineTransformIdentity
            self.capturarImage.alpha = 1
            self.capturarLabel.alpha = 1
            self.explorarImage.alpha = 1
            self.explorarLabel.alpha = 1
            })
        
        // Invoca a la segue dependiendo de lo seleccionado
        if generar {
            // Generar
            self.performSegueWithIdentifier("HomeCapturar", sender: self)
        } else {
            // Explorar
            self.performSegueWithIdentifier("HomeExplorar", sender: self)
        }
        
    }
    
}
