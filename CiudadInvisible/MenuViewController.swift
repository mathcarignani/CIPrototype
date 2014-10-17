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
    
    var airMenuController: XDKAirMenuController! = nil
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Menu
        self.airMenuController = XDKAirMenuController.sharedMenu()
        self.airMenuController.airDelegate = self
        
        self.view.addSubview(self.airMenuController.view)
        self.addChildViewController(self.airMenuController)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        vc = self.storyboard?.instantiateViewControllerWithIdentifier("PostsHome") as UIViewController
        
        return vc
    }
    
    func tableViewForAirMenu(airMenu: XDKAirMenuController!) -> UITableView! {
        return self.tableView
    }
}
