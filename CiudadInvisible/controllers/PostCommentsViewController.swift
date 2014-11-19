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
    @IBOutlet weak var text: UITextField!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

}
