//
//  PostsEntireViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 05/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class PostsDetailViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    var post : Post! = nil
    
    var portadaPostView : PostView = PostView()
    var backgroundImage = UIImageView()
    
    @IBOutlet var tableView : UITableView
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loadTableViewHeader()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: TableView
    
    func loadTableViewHeader() {
        //self.tableView.tableHeaderView = PostView(frame: view.frame, image: UIImage(named: "bg1.jpg"), name: "La Marilyn", distance: "500 m")
        
        tableView.backgroundColor = UIColor.clearColor()
        
        // Agrego la imagen en el fondo del header
        backgroundImage.frame = self.view.frame
        backgroundImage.image = post.imagen
        self.view.insertSubview(backgroundImage, belowSubview: tableView)
        
        // Configuro el header
        var headerView : UIView = UIView(frame: view.frame)
        headerView.backgroundColor = UIColor.clearColor()
        
        var postName = UILabel(frame: CGRect(x: 20, y: view.frame.height-100, width: view.frame.width - 20, height: 80))
        postName.text = post.titulo
        postName.font = UIFont(name: "Helvetica", size: 35)
        postName.textColor = UIColor.whiteColor()
        headerView.addSubview(postName)
        
        var backButton = UIButton(frame: CGRect(x: 10, y: 10, width: 80, height: 80))
        backButton.titleLabel.text = "< volver"
        backButton.titleLabel.font = UIFont(name: "Helvetica", size: 35)
        backButton.titleLabel.textColor = UIColor.whiteColor()
        backButton.addTarget(self, action: Selector("volver:"), forControlEvents: UIControlEvents.TouchUpInside)
        headerView.addSubview(backButton)
        
        self.tableView.tableHeaderView = headerView
        
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section:    Int) -> Int {
        return 10
    }
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "AporteCell")
        
        //cell.text = "Aporte #\(indexPath.row)"
        cell.detailTextLabel.text = "Comentario #\(indexPath.row)"
        
        return cell
    }
    
    // MARK: ScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        
        let scrollOffset = scrollView.contentOffset.y;
        
        if (scrollOffset < 0) {
            // Adjust image proportionally
            let escala = 1 - scrollOffset / 700
            backgroundImage.transform = CGAffineTransformMakeScale(escala, escala)
            
            tableView.tableHeaderView.backgroundColor = UIColor.clearColor()
            //backgroundImage.image.applyBlurWithRadius(0, tintColor: nil, saturationDeltaFactor: 1, maskImage: nil)
            
        } else {
            // We're scrolling up, return to normal behavior
            backgroundImage.transform = CGAffineTransformIdentity
            
            let blur = scrollOffset / 700
            
            tableView.tableHeaderView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: blur)
            
            //backgroundImage.setImageToBlur(UIImage(named: "bg1.jpg"), blurRadius: blur, completionBlock: nil)
            
        }
        
    }
    
    // MARK: Actions
    func volver(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
