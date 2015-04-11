//
//  CustomImageView.swift
//  CiudadInvisible
//
//  Created by Mathias on 4/5/15.
//  Copyright (c) 2015 CiudadInvisible. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
  
  let progressIndicatorView = CircularLoaderView(frame: CGRectZero)
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    addSubview(self.progressIndicatorView)
    progressIndicatorView.frame = bounds
    progressIndicatorView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
    
  }
  
  func loadImage(url: String!) {
    var imageRequest = NSURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 60)
    self.setImageWithURLRequest(imageRequest, placeholderImage: UIImage(named: "bgEmpty.png"), success: { (request, response, image) -> Void in
      // Setea las imagenes
      self.image = image
      self.progressIndicatorView.reveal()
      }, failure:nil)
    
  }
  
}
