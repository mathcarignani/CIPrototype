//
//  PostsHomeViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 17/10/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class PostsHomeViewController: UIViewController {

    var postsContainer: PostsContainerViewController! = nil
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    override func viewDidAppear(animated: Bool) {
        // Si no hay usuario logueado va al login
        if !UserSesionHelper.sharedInstance().hasUserLogued {
            self.performSegueWithIdentifier("BackToLoginSegue", sender: self)
        }
    }
    
    // MARK: - Actions
    @IBAction func menuClicked(sender: AnyObject) {
        let menu: XDKAirMenuController = XDKAirMenuController.sharedMenu()
        if menu.isMenuOpened {
            menu.closeMenuAnimated()
        } else {
            menu.openMenuAnimated()
        }
    }
    
    @IBAction func goToSlide(sender: AnyObject) {
        // Cambia el controlador
        self.postsContainer.changeToViewControllerIndex(0)
    }
    
    @IBAction func goToMap(sender: AnyObject) {
        // Cambia el controlador
        self.postsContainer.changeToViewControllerIndex(1)
    }
    
    @IBAction func goToGalery(sender: AnyObject) {
        // Cambia el controlador
        self.postsContainer.changeToViewControllerIndex(2)
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embedContainer" {
            self.postsContainer = segue.destinationViewController as PostsContainerViewController
        }
    }
}
