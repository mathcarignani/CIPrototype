//
//  PostImagesCellCollectionViewCell.swift
//  CiudadInvisible
//
//  Created by Mathias on 22/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class PostImagesCell: UICollectionViewCell {

    @IBOutlet var image: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
