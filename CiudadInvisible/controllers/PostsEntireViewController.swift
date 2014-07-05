//
//  PostsEntireViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 05/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class PostsEntireViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var portadaPostView : PostView = PostView()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loadTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: TableView
    
    func loadTableView() {
        self.tableView.tableHeaderView = PostView(frame: view.frame, image: UIImage(named: "bg1.jpg"), name: "La Marilyn", distance: "500 m")
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section:    Int) -> Int {
        return 10
    }
    
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "AporteCell")
        
        cell.text = "Aporte #\(indexPath.row)"
        cell.detailTextLabel.text = "Comentario #\(indexPath.row)"
        
        return cell
    }
    
    // MARK: ScrollViewDelegate
    override func scrollViewDidScroll(scrollView: UIScrollView!) {
        
        let scrollOffset = scrollView.contentOffset.y;
        
        if (scrollOffset < 0) {
            // Adjust image proportionally
            // self.tableView.tableHeaderView.transform = CGAffineTransformMakeScale(1.2, 1.2)
            
        } else {
            // We're scrolling up, return to normal behavior
            // self.tableView.tableHeaderView.transform = CGAffineTransformIdentity
        }

    }

}
