//
//  MenuTableViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 06/10/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    // MARK: - Properties
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UI
    func configUI() {
        // Avatar
        self.avatarImage.image = UIImage(named: "avatar.png")
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.width / 2
        self.avatarImage.layer.masksToBounds = true
        
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}
