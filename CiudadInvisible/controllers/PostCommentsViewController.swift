//
//  PostCommentsViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 8/11/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class PostCommentsViewController: UIViewController {
  
  var post: Post! = nil
  @IBOutlet weak var dialogView: SpringView!
  @IBOutlet weak var text: UITextField!
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  var firstTime = true
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(true)
    if firstTime {
      dialogView.animate()
      
      firstTime = false
    }
  }
  
  // MARK: - Actions
  @IBAction func sendComment(sender: AnyObject) {
    var comment: Comment = Comment()
    comment.text = self.text.text
    comment.post = self.post
    RestApiHelper.sharedInstance().createComment(comment, completion: { (success) -> () in
      if success {
        println("success")
      } else {
        println("error")
      }
    })
  }
 
  @IBAction func closeMenu() {
    dialogView.animation = "fall"
    dialogView.animateNext {
      self.dismissViewControllerAnimated(false, completion: nil)
    }
  }
}
