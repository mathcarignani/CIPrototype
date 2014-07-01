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
    
    @IBOutlet var cameraButton : UIButton
    
    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPosts()
        setupGestures()
        
    }

    func loadPosts() {
        
        centerPostView = PostView(frame: view.frame, image: UIImage(named: "bg1.jpg"), name: "El cierre", distance: "500 m")
        self.view.insertSubview(centerPostView, belowSubview: cameraButton)
        
        leftPostView = PostView(frame: view.frame, image: UIImage(named: "bg1.jpg"), name: "El cierre", distance: "500 m")
        leftPostView.center = CGPoint(x: leftPostView.center.x - 320, y: leftPostView.center.y)
        self.view.insertSubview(leftPostView, belowSubview: cameraButton)
        
        rightPostView = PostView(frame: view.frame, image: UIImage(named: "bg1.jpg"), name: "El cierre", distance: "500 m")
        rightPostView.center = CGPoint(x: rightPostView.center.x + 320, y: rightPostView.center.y)
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
        
            var point = gesture.translationInView(view)
            
            var translation = CGAffineTransformMakeTranslation(point.x, 0)
            var scale = CGAffineTransformMakeScale(0.8, 0.8)
            var transform = CGAffineTransformConcat(translation, scale)
            centerPostView.transform = transform
            leftPostView.transform = transform
            rightPostView.transform = transform
            
            break;
        case UIGestureRecognizerState.Ended:
        
            UIView.animateWithDuration(0.2, animations: {
                self.cameraButton.transform = CGAffineTransformMakeTranslation(0, 0)
                self.centerPostView.transform = CGAffineTransformIdentity
                self.leftPostView.transform = CGAffineTransformIdentity
                self.rightPostView.transform = CGAffineTransformIdentity
                })
            break;
        default:
            break;
        }
        
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
