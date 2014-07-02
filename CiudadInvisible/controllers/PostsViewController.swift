//
//  PostsViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 28/06/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
    
    // MARK: Outlets
    var centerPostView : PostView = PostView()
    var leftPostView : PostView = PostView()
    var rightPostView : PostView = PostView()
    
    var leftCenterX : Float = 0
    var leftCenterY : Float = 0
    var centerCenterX : Float = 0
    var centerCenterY : Float = 0
    var rightCenterX : Float = 0
    var rightCenterY : Float = 0
    
    enum Transition {
        case None
        case LeftToCenter
        case RightToCenter
    }
    
    @IBOutlet var cameraButton : UIButton
    
    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cargo las variables
        leftCenterX = view.center.x - 320
        leftCenterY = view.center.y
        centerCenterX = view.center.x
        centerCenterY = view.center.y
        rightCenterX = view.center.x + 320
        rightCenterY = view.center.y
        
        loadPosts()
        setupGestures()
        
    }

    func loadPosts() {
        // Izquierda
        leftPostView = PostView(frame: view.frame, image: UIImage(named: "bg2.jpg"), name: "El cierre", distance: "400 m")
        leftPostView.center = CGPoint(x: leftCenterX, y: leftCenterY)
        self.view.insertSubview(leftPostView, belowSubview: cameraButton)
        // Centro
        centerPostView = PostView(frame: view.frame, image: UIImage(named: "bg1.jpg"), name: "La Marilyn", distance: "500 m")
        centerPostView.center = CGPoint(x: centerCenterX, y: centerCenterY)
        self.view.insertSubview(centerPostView, belowSubview: cameraButton)
        // Derecha
        rightPostView = PostView(frame: view.frame, image: UIImage(named: "bg3.jpg"), name: "La Plaza", distance: "600 m")
        rightPostView.center = CGPoint(x: rightCenterX, y: rightCenterY)
        self.view.insertSubview(rightPostView, belowSubview: cameraButton)
       
    }
    
    func setupGestures() {
        
        let panGesture = UIPanGestureRecognizer(target: self, action: Selector("panHandled:"))
        view.addGestureRecognizer(panGesture)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: Selector("tapHandled:"))
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
        
        
    }
    
    // MARK: Touch methods
    func tapHandled (gesture : UITapGestureRecognizer) {
        println("tapHandled")
    }
    
    func panHandled (gesture : UIPanGestureRecognizer) {
        
        var point = gesture.translationInView(view)
        
        switch (gesture.state) {
        case UIGestureRecognizerState.Began:
        
            UIView.animateWithDuration(0.2, animations: {
                self.cameraButton.transform = CGAffineTransformMakeTranslation(0, 100)
                self.centerPostView.transform = CGAffineTransformMakeScale(0.8, 0.8)
                self.leftPostView.transform = CGAffineTransformMakeScale(0.8, 0.8)
                self.rightPostView.transform = CGAffineTransformMakeScale(0.8, 0.8)
            })
            break;
        case UIGestureRecognizerState.Changed:
        
            let translation = CGAffineTransformMakeTranslation(point.x, 0)
            let scale = CGAffineTransformMakeScale(0.8, 0.8)
            let transform = CGAffineTransformConcat(translation, scale)
            centerPostView.transform = transform
            leftPostView.transform = transform
            rightPostView.transform = transform
            
            break;
        case UIGestureRecognizerState.Ended:
        
            var delay : NSTimeInterval = 0
            var transition : Transition = Transition.None
            // Controlo la posicion donde se soltó
            if point.x > 140 {
                // Pasa el left al center
                // Seteo el centro en el lugar donde estan ahora
                self.leftPostView.center = CGPoint(x: self.leftCenterX + point.x, y: self.leftCenterY)
                self.centerPostView.center = CGPoint(x: self.centerCenterX + point.x, y: self.centerCenterY)
                
                UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
                        //
                        self.centerPostView.transform = CGAffineTransformMakeScale(0.8, 0.8)
                        self.leftPostView.transform = CGAffineTransformMakeScale(0.8, 0.8)
                        self.centerPostView.center = CGPoint(x: self.rightCenterX, y: self.rightCenterY)
                        self.leftPostView.center = CGPoint(x: self.centerCenterX, y: self.centerCenterY)
                    }
                    , completion: { (finished: Bool) in
                        //
                    })
                
                delay = 0.2 // Espera a que termine la animacion anterior
                transition = Transition.LeftToCenter
                
            }
            else if point.x < -140 {
                // Pasa el rigth al center
                // Seteo el centro en el lugar donde estan ahora
                self.rightPostView.center = CGPoint(x: self.rightCenterX + point.x, y: self.rightCenterY)
                self.centerPostView.center = CGPoint(x: self.centerCenterX + point.x, y: self.centerCenterY)
                
                UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
                    //
                    self.centerPostView.transform = CGAffineTransformMakeScale(0.8, 0.8)
                    self.rightPostView.transform = CGAffineTransformMakeScale(0.8, 0.8)
                    self.centerPostView.center = CGPoint(x: self.leftCenterX, y: self.leftCenterY)
                    self.rightPostView.center = CGPoint(x: self.centerCenterX, y: self.centerCenterY)
                    }
                    , completion: { (finished: Bool) in
                        //
                    })
                
                delay = 0.2 // Espera a que termine la animacion anterior
                transition = Transition.RightToCenter
            }
            else {
                // Queda igual
            }
            
            // Vuelven a su estado normal
            UIView.animateWithDuration(0.2, delay: delay, options: UIViewAnimationOptions.CurveLinear, animations: {
                    self.cameraButton.transform = CGAffineTransformMakeTranslation(0, 0)
                    self.centerPostView.transform = CGAffineTransformIdentity
                    self.leftPostView.transform = CGAffineTransformIdentity
                    self.rightPostView.transform = CGAffineTransformIdentity
                }
                , completion: { (finished: Bool) in
                    //
                    self.initilizePosts(transition)
                })

            break;
        default:
            break;
        }
        
    }
    
    func initilizePosts (position : Transition) {
        if (position == Transition.LeftToCenter) {
            let aux = leftPostView
            leftPostView = rightPostView
            rightPostView = centerPostView
            centerPostView = aux
            
        }
        else if (position == Transition.RightToCenter) {
            let aux = rightPostView
            rightPostView = leftPostView
            leftPostView = centerPostView
            centerPostView = aux
            
        }
        
        leftPostView.center = CGPoint(x: leftCenterX, y: leftCenterY)
        centerPostView.center = CGPoint(x: centerCenterX, y: centerCenterY)
        rightPostView.center = CGPoint(x: rightCenterX, y: rightCenterY)
    }
    
    /*
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        
        UIView.animateWithDuration(0.2, animations: {
            self.cameraButton.transform = CGAffineTransformMakeTranslation(0, 100)
            self.centerPostView.transform = CGAffineTransformMakeScale(0.9, 0.9)
        })
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!)  {
        
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!)  {
        
        UIView.animateWithDuration(0.2, animations: {
            self.cameraButton.transform = CGAffineTransformMakeTranslation(0, 0)
            self.centerPostView.transform = CGAffineTransformMakeScale(1, 1)
        })
        
    }
*/
}
