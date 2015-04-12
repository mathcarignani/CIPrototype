//
//  PostCommentCell.swift
//  CiudadInvisible
//
//  Created by Mathias on 4/12/15.
//  Copyright (c) 2015 CiudadInvisible. All rights reserved.
//

import UIKit

class PostCommentCell: UITableViewCell {

  @IBOutlet var commentText: UITextView!
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
