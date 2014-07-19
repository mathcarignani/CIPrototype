//
//  PostsSlideViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 10/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class PostsSlideViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet var collectionView : UICollectionView
    
    var posts : NSArray! = nil
    
    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Obtengo los posts
        self.posts = RestApiHelper.sharedInstance().getPostsSlider()
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
    {
        return self.posts.count
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("PostSlideCell", forIndexPath: indexPath) as PostSlideCell
        
        // Configuro la celda
        let post = self.posts.objectAtIndex(indexPath.row) as Post
        cell.titulo.text = post.titulo
        cell.distancia.text = post.distancia
        cell.imagen.image = post.imagen
        
        // Sombreado
        cell.fondo.layer.shadowColor = UIColor.blackColor().CGColor;
        cell.fondo.layer.shadowOffset = CGSizeMake(2.5, 2.5);
        cell.fondo.layer.shadowOpacity = 0.6;
        cell.fondo.layer.shadowRadius = 1.0;
        cell.fondo.clipsToBounds = false;
        //
        
        return cell
    }
    
    // MARK: Auxiliares
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "VerDetalle") {

            var postDetailVC = segue.destinationViewController as PostsDetailViewController
            var index = self.collectionView.indexPathsForSelectedItems()[0] as NSIndexPath
            postDetailVC.post = self.posts.objectAtIndex(index.row) as Post
            
        }
    }
    
}
