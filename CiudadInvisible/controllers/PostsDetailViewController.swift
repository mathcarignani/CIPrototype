//
//  PostsEntireViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 05/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit
import MapKit

class PostsDetailViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    var post : Post! = nil
    
    var portadaPostView : PostView = PostView()
    var backgroundImage = UIImageView()
    var backgroundView = UIView()
    var imageEmpty : UIImage = UIImage(named: "bgEmpty.jpg")!
    
    @IBOutlet var tableView : UITableView!
    
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
        backgroundView.frame = self.view.frame
        if post.images.count > 0 {
            // Si tiene imagen la carga
            let images = post.imagesLarge()
            backgroundImage.setImageWithURL(NSURL(string: images.objectAtIndex(0) as String), placeholderImage: self.imageEmpty)
        }
        self.view.insertSubview(backgroundImage, belowSubview: tableView)
        self.view.insertSubview(backgroundView, aboveSubview: backgroundImage)
        
        var backButton = UIButton(frame: CGRect(x: 20, y: 20, width: 30, height: 30))
        backButton.backgroundColor = UIColor.clearColor()
        //backButton.titleLabel.font = UIFont(name: "Helvetica", size: 35)
        backButton.setTitle("<", forState: .Normal)
        backButton.setTitleColor(UIColor(red: 0, green: 146/255.0, blue: 105/255.0, alpha: 1), forState: .Normal)
        backButton.addTarget(self, action: Selector("volver:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(backButton)
        
        /*
        
        // Configuro el header
        var headerView : UIView = UIView(frame: view.frame)
        headerView.backgroundColor = UIColor.clearColor()
        
        // Name
        var postName = UILabel(frame: CGRect(x: 20, y: view.frame.height-100, width: view.frame.width - 20, height: 80))
        postName.text = post.title
        postName.font = UIFont(name: "Helvetica", size: 35)
        postName.textColor = UIColor.whiteColor()
        headerView.addSubview(postName)

        // Author
        var postAuthor = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 40, height: 20))
        postAuthor.text = post.author
        postAuthor.font = UIFont(name: "Helvetica", size: 14)
        postAuthor.textColor = UIColor.whiteColor()
        postAuthor.textAlignment = NSTextAlignment.Right
        var postAuthorButton = UIButton(frame: CGRect(x: 20, y: view.frame.height-40, width: view.frame.width - 40, height: 20))
        postAuthorButton.addSubview(postAuthor)
        postAuthorButton.addTarget(self, action:Selector("showUserProfile:") , forControlEvents: UIControlEvents.TouchUpInside)
        headerView.addSubview(postAuthorButton)
        
        // Avatar
        var avatar = UIImageView(image: UserSesionHelper.sharedInstance().getUserLogued().avatar())
        avatar.center = CGPointMake(230, 400)
        avatar.layer.cornerRadius = avatar.frame.width / 2
        avatar.layer.masksToBounds = true
        avatar.transform = CGAffineTransformMakeScale(0.4, 0.4)
        headerView.addSubview(avatar)
        
        // Favorito
/*
        var favButton = UIButton(frame: CGRectMake(self.view.frame.size.width - 50, self.view.frame.size.height - 50, 30, 30))
        favButton.setTitle("Fav", forState: .Normal)
        favButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        favButton.addTarget(self, action: "favorite:", forControlEvents: .TouchUpInside)
        headerView.addSubview(favButton)
*/
        // Comments
        var postComments = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        postComments.text = "\(post.comments.count)"
        postComments.font = UIFont(name: "Helvetica", size: 14)
        postComments.textColor = UIColor.whiteColor()
        postComments.textAlignment = NSTextAlignment.Right
        var postCommentsButton = UIButton(frame: CGRect(x: 20, y: view.frame.height-100, width: 40, height: 40))
        postCommentsButton.addSubview(postComments)
        postCommentsButton.addTarget(self, action:Selector("showComments:") , forControlEvents: UIControlEvents.TouchUpInside)
        headerView.addSubview(postCommentsButton)
        
        
        // Flecha
        var flechaView = UIImageView(image: HelperForms.imageOfFlecha)
        flechaView.center = CGPointMake(headerView.center.x, headerView.frame.size.height - 20)
        headerView.addSubview(flechaView)
        
        self.tableView.tableHeaderView = headerView

        */
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell! = nil
        
        if (indexPath.row == 0) {
            // Header
            cell = tableView.dequeueReusableCellWithIdentifier("PostHeaderCell", forIndexPath: indexPath) as PostDetailHeaderCell
            cell.backgroundColor = UIColor.clearColor()
            cell.contentView.backgroundColor = UIColor.clearColor()
            
            (cell as PostDetailHeaderCell).nameText.text = post.title
            (cell as PostDetailHeaderCell).authorText.text = "by \(post.author)"
            (cell as PostDetailHeaderCell).avatarImage.setImageWithURL(NSURL(string: post.author_avatar))
            (cell as PostDetailHeaderCell).avatarImage.layer.cornerRadius = (cell as PostDetailHeaderCell).avatarImage.frame.width / 2
            (cell as PostDetailHeaderCell).avatarImage.layer.masksToBounds = true
            
        } else if (indexPath.row == 1) {
            // Imagenes
            cell = tableView.dequeueReusableCellWithIdentifier("PostImagesCell", forIndexPath: indexPath) as UITableViewCell
            
        } else if (indexPath.row == 2) {
            // Descripcion
            cell = tableView.dequeueReusableCellWithIdentifier("PostDescriptionCell", forIndexPath: indexPath) as PostDetailDescriptionCell
            // Configuro los valores
            (cell as PostDetailDescriptionCell).descriptionText.text = post.descriptionText
            (cell as PostDetailDescriptionCell).categoryText.text = post.category
            
        } else if (indexPath.row == 3) {
            // Mapa
            cell = tableView.dequeueReusableCellWithIdentifier("PostMapCell", forIndexPath: indexPath) as PostDetailMapCell
            // Configuracion del mapa
            var mapa : MKMapView = (cell as PostDetailMapCell).mapa
            let coordinate = self.post.coordinate()
            MapHelper.centerMap(mapa, coordinate: coordinate, distance: 1000)
            MapHelper.addAnotationToMap(mapa, coordinate: coordinate, title: post.title)
        }
    
        return cell
    }

    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        
        if (indexPath.row == 0) {
            // Header
            return self.view.frame.size.height
        } else if (indexPath.row == 1) {
            // Imagenes
            return 141
        } else if (indexPath.row == 2) {
            // Descripcion
            return 200
        } else if (indexPath.row == 3) {
            // Mapa
            return 141
        } else {
            return 141
        }
    }
    
    // MARK: ScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        
        let scrollOffset = scrollView.contentOffset.y;
        
        if (scrollOffset < 0) {
            // Adjust image proportionally
            let escala = 1 - scrollOffset / 700
            backgroundImage.transform = CGAffineTransformMakeScale(escala, escala)
            
            //tableView.tableHeaderView.backgroundColor = UIColor.clearColor()
            tableView.backgroundView?.backgroundColor = UIColor.clearColor()
            //backgroundImage.image.applyBlurWithRadius(0, tintColor: nil, saturationDeltaFactor: 1, maskImage: nil)
            
        } else {
            // We're scrolling up, return to normal behavior
            backgroundImage.transform = CGAffineTransformIdentity
            
            let blur = scrollOffset / 700
            
            tableView.backgroundView?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: blur)
            
            //backgroundImage.setImageToBlur(UIImage(named: "bg1.jpg"), blurRadius: blur, completionBlock: nil)
            
        }
        
    }
    
    // MARK: UICollectionViewDataSource - Images
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
    {
        return self.post.images.count - 1 // Le saca la principal
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!
    {
        var cell : PostImagesCell = collectionView.dequeueReusableCellWithReuseIdentifier("PostImageCell", forIndexPath: indexPath) as PostImagesCell
        
        // Configuro la celda, al indexPath le suma uno porque la primera no se considera
        let images = post.imagesSmall()
        cell.image.setImageWithURL(NSURL(string: images.objectAtIndex(indexPath.row + 1) as String), placeholderImage: self.imageEmpty)
        
        return cell
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showComments" {
            (segue.destinationViewController as PostCommentsViewController).post = self.post
        }
    }
    
    // MARK: Actions
    func volver(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func favorite(sender: AnyObject) {
        RestApiHelper.sharedInstance().favoritePost(self.post.id, userId: UserSesionHelper.sharedInstance().getUserLogued().id)
            { (success) -> () in
            
        }
    }
    
    func showUserProfile(sender: AnyObject) {
        println("showUserProfile");
    }
    
    func showComments(sender: AnyObject) {
        self.performSegueWithIdentifier("showComments", sender: self)
    }

}
