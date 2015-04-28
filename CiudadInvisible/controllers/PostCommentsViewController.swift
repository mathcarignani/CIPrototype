//
//  PostCommentsViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 8/11/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class PostCommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var post: Post! = nil
  @IBOutlet weak var dialogView: SpringView!
  @IBOutlet weak var text: UITextField!
  @IBOutlet weak var tableView: UITableView!
  
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
    ProgressHUD.show("Enviando...")
    var comment: Comment = Comment()
    comment.text = self.text.text
    comment.post = self.post
    RestApiHelper.sharedInstance().createComment(comment, completion: { (success) -> () in
      
      self.text.text = ""
      comment.avatar = UserSesionHelper.sharedInstance().userLogued.url_avatar
      comment.first_name = UserSesionHelper.sharedInstance().userLogued.first_name
      comment.last_name = UserSesionHelper.sharedInstance().userLogued.last_name
      (self.post.comments as NSMutableArray).insertObject(comment, atIndex: 0)
      
      ProgressHUD.dismiss()
      self.tableView.reloadData()
      
    })
  }
 
  @IBAction func closeMenu() {
    dialogView.animation = "fall"
    dialogView.animateNext {
      self.dismissViewControllerAnimated(false, completion: nil)
    }
  }
  
  // MARK: - UITableView
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.post.comments.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("PostComment", forIndexPath: indexPath) as! PostCommentCell
    // Configuro los valores
    let comment = self.post.comments.objectAtIndex(indexPath.row) as! Comment
    (cell as! PostCommentCell).avatarImage.setImageWithURL(NSURL(string: comment.avatar))
    (cell as! PostCommentCell).avatarImage.layer.cornerRadius = 30
    (cell as! PostCommentCell).avatarImage.layer.masksToBounds = true
    (cell as! PostCommentCell).authorText.text = "\(comment.first_name) \(comment.last_name)"
    (cell as! PostCommentCell).commentText.text = comment.text
    
    return cell
  }
}
