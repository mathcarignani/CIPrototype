//
//  PostDetailDescriptionCell.swift
//  CiudadInvisible
//
//  Created by Mathias on 30/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class PostDetailDescriptionCell: UITableViewCell {
    
    @IBOutlet var descriptionText: UILabel
    @IBOutlet var categoryText: UILabel
    
    init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
    }
}
