//
//  PostsContainerViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 17/10/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class PostsContainerViewController: UIViewController {

    private let SegueIdentifierFirst: String! = "embedSlide"
    private let SegueIdentifierSecond: String! = "embedMap"
    private let SegueIdentifierThird: String! = "embedGallery"
    private var currentSegueIdentifier: String! = ""
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Controlador principal
        self.currentSegueIdentifier = SegueIdentifierFirst
        self.performSegueWithIdentifier(self.currentSegueIdentifier, sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueIdentifierFirst {
            if self.childViewControllers.count > 0 {
                self.swapFromViewController(((self.childViewControllers as NSArray).objectAtIndex(0) as UIViewController), toViewController: (segue.destinationViewController as UIViewController))
            } else {
                self.addChildViewController(segue.destinationViewController as UIViewController)
                (segue.destinationViewController as UIViewController).view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                self.view.addSubview((segue.destinationViewController as UIViewController).view)
                segue.destinationViewController.didMoveToParentViewController(self)
            }
        } else {
            self.swapFromViewController(((self.childViewControllers as NSArray).objectAtIndex(0) as UIViewController), toViewController: (segue.destinationViewController as UIViewController))
        }
    }
    
    private func swapFromViewController(fromViewController: UIViewController, toViewController: UIViewController) {
        
        toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        fromViewController.willMoveToParentViewController(nil)
        self.addChildViewController(toViewController)
        
        self.transitionFromViewController(
            fromViewController,
            toViewController: toViewController,
            duration: 0.8,
            options: UIViewAnimationOptions.TransitionCrossDissolve,
            animations: { () -> Void in
                
            },
            completion: { finished in
                fromViewController.removeFromParentViewController()
                toViewController.didMoveToParentViewController(self)
        })
        
        
        
    }
    
    func changeToViewControllerIndex(index: NSInteger) {
        if index == 0 {
            self.currentSegueIdentifier = SegueIdentifierFirst
        } else if index == 1 {
            self.currentSegueIdentifier = SegueIdentifierSecond
        } else {
            self.currentSegueIdentifier = SegueIdentifierThird
        }
        // Ejecuta el segue
        self.performSegueWithIdentifier(self.currentSegueIdentifier, sender: nil)
    }

}
