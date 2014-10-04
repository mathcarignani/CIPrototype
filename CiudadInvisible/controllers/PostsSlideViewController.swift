//
//  PostsSlideViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 10/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class PostsSlideViewController: UIViewController, UICollectionViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet var collectionView : UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var posts : NSArray! = NSArray()
    var imageEmpty : UIImage = UIImage(named: "bgEmpty.jpg")
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Obtengo los posts
        self.loadingIndicator.startAnimating()
        self.loadingIndicator.hidden = false

        RestApiHelper.sharedInstance().getPosts(
            { (postsReturn: NSArray) in
                self.posts = postsReturn
                
                // Recarga el slides
                self.collectionView.reloadData()
                // Oculta el indicador
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.hidden = true
            })
    }

    // MARK: - Actions
    @IBAction func goToMap(sender: AnyObject) {
        
        // Obtiene el mapa, setea los posts para que no los obtenga denuevo y lo invoca
        //var mapVC : PostsMapViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PostsMapViewController") as PostsMapViewController
        var mapVC : PostARViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PostARViewController") as PostARViewController
        mapVC.posts = self.posts
        self.presentViewController(mapVC, animated: true) { () -> Void in
        }
    }
    
    @IBAction func goToGalery(sender: AnyObject) {
        
        // Obtiene el mapa, setea los posts para que no los obtenga denuevo y lo invoca
        var galeryVC : PostsGaleryViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PostsGaleryViewController") as PostsGaleryViewController
        galeryVC.posts = self.posts
        self.presentViewController(galeryVC, animated: true) { () -> Void in
        }
    }
    
    @IBAction func menuClicked(sender: AnyObject) {
        let menu: XDKAirMenuController = XDKAirMenuController.sharedMenu()
        if menu.isMenuOpened {
            menu.closeMenuAnimated()
        } else {
            menu.openMenuAnimated()
        }
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.posts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("PostSlideCell", forIndexPath: indexPath) as PostSlideCell
        
        // Configuro la celda
        let post = self.posts.objectAtIndex(indexPath.row) as Post
        cell.titulo.text = post.title
        cell.distancia.text = ""
        cell.imagen.image = self.imageEmpty
        if post.images.count > 0 {
            // Si tiene imagen la carga
            let images = post.imagesMedium()
            cell.imagen.setImageWithURL(NSURL(string: images.objectAtIndex(0) as String), placeholderImage: self.imageEmpty)
        }
        
        // Sombreado
        cell.fondo.layer.shadowColor = UIColor.blackColor().CGColor;
        cell.fondo.layer.shadowOffset = CGSizeMake(2.5, 2.5);
        cell.fondo.layer.shadowOpacity = 0.6;
        cell.fondo.layer.shadowRadius = 1.0;
        cell.fondo.clipsToBounds = false;
        //
        
        return cell
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // Obtiene la celda visible
        let visibleCell = (self.collectionView.visibleCells() as NSArray).firstObject as PostSlideCell
        self.setImageToBackground(visibleCell.imagen.image!)
    }
    
    // MARK: - Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        //if segue != nil {
            if (segue.identifier == "VerDetalle") {

                var postDetailVC = segue.destinationViewController as PostsDetailViewController
                var index = self.collectionView.indexPathsForSelectedItems()[0] as NSIndexPath
                postDetailVC.post = self.posts.objectAtIndex(index.row) as Post
                
            }
        //}
    }
    
    // MARK: - Auxiliares
    func setImageToBackground(image: UIImage) {
        self.backgroundImage.setImageToBlur(image, blurRadius: 4.0) { () -> Void in
            
        }
    }
}
