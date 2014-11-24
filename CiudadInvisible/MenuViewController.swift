//
//  MenuViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 04/10/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, XDKAirMenuDelegate {

    weak var tableView: UITableView!
    
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    var airMenuController: XDKAirMenuController! = nil
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Menu
        self.airMenuController = XDKAirMenuController.sharedMenu()
        self.airMenuController.airDelegate = self
        
        self.view.addSubview(self.airMenuController.view)
        self.addChildViewController(self.airMenuController)
        
        self.configUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI
    func configUI() {
        if UserSesionHelper.sharedInstance().hasUserLogued {
            let user: User = UserSesionHelper.sharedInstance().getUserLogued()
            self.name.text = user.name()
            self.avatar.setImageWithURL(NSURL(string: user.url_avatar))
            self.avatar.layer.cornerRadius = self.avatar.frame.width / 2
            self.avatar.layer.masksToBounds = true
            
            var tapInView = UITapGestureRecognizer(target: self, action: Selector("showUserProfile:"))
        }
    }
    
    func showUserProfile(gesture : UITapGestureRecognizer) {
        
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Si la accion es embeber la tabla actualiza la variable de la tabla
        if segue.identifier == "ManuTableViewSegue" {
            self.tableView = (segue.destinationViewController as UITableViewController).tableView
        }
    }
    
    // MARK: - XDKAirMenuDelegate
    func airMenu(airMenu: XDKAirMenuController!, viewControllerAtIndexPath indexPath: NSIndexPath!) -> UIViewController! {
        
        var vc: UIViewController! = nil
        
        if indexPath.row == 2 {
            // Tour
            vc = self.storyboard?.instantiateViewControllerWithIdentifier("PostTour") as UIViewController
        } else if indexPath.row == 3 {
            // Posts de usuario
            vc = self.storyboard?.instantiateViewControllerWithIdentifier("PostsHome") as PostsHomeViewController
            (vc as PostsHomeViewController).typePosts = 1 // Posts de usuario
        } else if indexPath.row == 4 {
            // Favoritos de usuario
            vc = self.storyboard?.instantiateViewControllerWithIdentifier("PostsHome") as PostsHomeViewController
            (vc as PostsHomeViewController).typePosts = 2 // Favoritos de usuario
        } else {
            vc = self.storyboard?.instantiateViewControllerWithIdentifier("PostsHome") as UIViewController
        }
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        return vc
    }
    
    func tableViewForAirMenu(airMenu: XDKAirMenuController!) -> UITableView! {
        return self.tableView
    }
    
    
}
