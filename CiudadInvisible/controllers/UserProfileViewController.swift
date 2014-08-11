//
//  UserProfileViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 09/08/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet var backgroundImage: UIImageView
    @IBOutlet var avatarImage: UIImageView
    @IBOutlet var nameText: UILabel
    
    var user: User! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.user = UserSesionHelper.sharedInstance().getUserLogued()
        self.configOutlets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Outlets
    func configOutlets() {
        
        // Avatar
        self.avatarImage.image = self.user.avatar()
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.width / 2
        self.avatarImage.layer.masksToBounds = true
        
        // Background avatar
        self.backgroundImage.setImageToBlur(self.user.avatar(), blurRadius: 10, completionBlock: nil)

        // Nombre
        self.nameText.text = self.user.name()
        
        
    }
    
}
