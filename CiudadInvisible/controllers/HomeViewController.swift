//
//  HomeViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 20/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit
import QuartzCore

class HomeViewController: UIViewController {

    @IBOutlet var capturarImage: UIImageView
    @IBOutlet var capturarLabel: UILabel
    
    @IBOutlet var explorarImage: UIImageView
    @IBOutlet var explorarLabel: UILabel
    
    var mask: CALayer?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // MASK
        
        self.mask = CALayer()
        self.mask!.contents = UIImage(named: "logoMask.png").CGImage
        self.mask!.bounds = CGRect(x: 0, y: 0, width: 110, height: 192)
        self.mask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.mask!.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        self.view.layer.mask = mask
        
        animateMask()
        // MASK
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Si no hay usuario logueado va al login
        if !RestApiHelper.sharedInstance().hasUserLogued {
            self.performSegueWithIdentifier("BackToLoginSegue", sender: self)
        }
        
    }
    
    // MARK: Touches
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
    
    // PRUEBA
    func animateMask() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 1
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 1 //add delay of 1 second
        let initalBounds = NSValue(CGRect: mask!.bounds)
        let secondBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 99, height: 173))
        let finalBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 1500, height: 1500))
        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.3, 1]
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        self.mask!.addAnimation(keyFrameAnimation, forKey: "bounds")
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        self.view!.layer.mask = nil //remove mask when animation completes
    }

    // PRUEBA
}
