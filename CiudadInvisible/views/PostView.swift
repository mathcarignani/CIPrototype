//
//  PostView.swift
//  CiudadInvisible
//
//  Created by Mathias on 28/06/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class PostView: UIView {
    
    var postImage : UIImageView = UIImageView()
    var postName : UILabel = UILabel()
    var postDistance : UILabel = UILabel()
    var postInformationBackground : UIView = UIView()
  
    let defaultFrame = CGRectMake(0, 0, 140, 40)
  
    required override init() {
        super.init(frame: defaultFrame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, image: UIImage, name: NSString, distance: NSString) {
        
        postImage = UIImageView(frame: frame)
        postImage.image = image
        
        postName = UILabel(frame: CGRect(x: 10, y: frame.height-40, width: (frame.width/2)-30, height: 40))
        postName.text = name as String
        
        postDistance = UILabel(frame: CGRect(x: (frame.width/2)+30, y: frame.height-40, width: (frame.width/2)-40, height: 40))
        postDistance.textAlignment = NSTextAlignment.Right
        postDistance.text = distance as String
        
        postInformationBackground = UIView(frame: CGRectMake(0, frame.height-40, frame.width, 40))
        postInformationBackground.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7)
        
        
        // Inicializo y agrego las subvistas
        super.init(frame: frame)
        self.addSubview(postImage)
        self.addSubview(postInformationBackground)
        self.addSubview(postName)
        self.addSubview(postDistance)
    }
    
}
