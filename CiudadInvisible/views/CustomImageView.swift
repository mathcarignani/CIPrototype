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
    
//    let url = NSURL(string: "http://www.raywenderlich.com/wp-content/uploads/2015/02/mac-glasses.jpeg")
//    self.sd_setImageWithURL(url, placeholderImage: nil, options: .CacheMemoryOnly , progress: { [weak self](receivedSize, expectedSize) -> Void in
//      self!.progressIndicatorView.progress = CGFloat(receivedSize)/CGFloat(expectedSize)
//      }) { [weak self](image, error, _, _) -> Void in
//        self!.progressIndicatorView.reveal()
//    }
  }

  func loadImage(url: String!) {
      self.setImageWithURLRequest(NSURLRequest(URL: NSURL(string: url)!), placeholderImage: UIImage(named: "bgEmpty.png"), success: { (request, response, image) -> Void in
          // Setea las imagenes
          self.image = image
          self.progressIndicatorView.reveal()
        }, failure:nil)

  }
  
}
