//
//  PostsGaleryViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 30/08/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class PostsGaleryViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet var collectionView : UICollectionView!
    
    var posts : NSArray! = NSArray()
    var imageEmpty : UIImage = UIImage(named: "bgEmpty.jpg")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Si no hay posts los voy a buscar a la API
        if self.posts != nil {
            // Obtengo los posts
            RestApiHelper.sharedInstance().getPosts(
                { (postsReturn: NSArray) in
                    self.posts = postsReturn

                    // Recarga la galeria
                    self.collectionView.reloadData()
            })
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.posts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("PostGaleryCell", forIndexPath: indexPath) as PostSlideCell
        
        // Configuro la celda
        let post = self.posts.objectAtIndex(indexPath.row) as Post
        //cell.titulo.text = post.title
        //cell.distancia.text = ""
        cell.imagen.image = self.imageEmpty
        if post.images.count > 0 {
            // Si tiene imagen la carga
            let images = post.imagesSmall()
            cell.imagen.setImageWithURL(NSURL(string: images.objectAtIndex(0) as String), placeholderImage: self.imageEmpty)
        }
        
        // Sombreado
        /*
        cell.fondo.layer.shadowColor = UIColor.blackColor().CGColor;
        cell.fondo.layer.shadowOffset = CGSizeMake(2.5, 2.5);
        cell.fondo.layer.shadowOpacity = 0.6;
        cell.fondo.layer.shadowRadius = 1.0;
        cell.fondo.clipsToBounds = false;
        */
        //
        
        return cell
    }
    
    // MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        if segue != nil {
            if (segue.identifier == "VerDetalle") {
                
                var postDetailVC = segue.destinationViewController as PostsDetailViewController
                //var index = self.collectionView.indexPathsForSelectedItems()[0] as NSIndexPath
                //postDetailVC.post = self.posts.objectAtIndex(index.row) as Post
                
                // CAMBIARRR
                postDetailVC.post = self.posts.objectAtIndex(0) as Post
                
            }
//        }
    }

}
