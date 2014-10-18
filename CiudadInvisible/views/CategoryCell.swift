//
//  CategoryCell.swift
//  CiudadInvisible
//
//  Created by Mathias on 18/10/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet var name: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
}
