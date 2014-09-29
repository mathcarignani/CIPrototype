//
//  PostSlideCell.swift
//  CiudadInvisible
//
//  Created by Mathias on 10/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class PostSlideCell: UICollectionViewCell {

    @IBOutlet var fondo: UIView!
    @IBOutlet var titulo: UILabel!
    @IBOutlet var distancia: UILabel!
    @IBOutlet var imagen: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
