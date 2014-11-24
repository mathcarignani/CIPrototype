//
//  PostDetailHeaderCell.swift
//  CiudadInvisible
//
//  Created by Mathias on 19/11/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class PostDetailHeaderCell: UITableViewCell {

    @IBOutlet var nameText: UILabel!
    @IBOutlet var authorText: UILabel!
    @IBOutlet var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
