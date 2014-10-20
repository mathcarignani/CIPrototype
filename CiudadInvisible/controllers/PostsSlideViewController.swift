//
//  PostsSlideViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 10/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class PostsSlideViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet var collectionView : UICollectionView!
    @IBOutlet weak var filtersCollectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var posts: NSArray! = NSArray()
    var filters: [String] = []
    var imageEmpty: UIImage = UIImage(named: "bgEmpty.jpg")
    var filterSelected: String = "Todos"
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Carga los filtros
        self.filters = ["Todos", "Recomendados", "Cercanos", "Favoritos", "Seguidores"]
    
        // Obtiene los posts
        self.getData()
    }
    
    // MARK: - Data
    func getData() {
        
        // Obtengo los posts
        self.loadingIndicator.startAnimating()
        self.loadingIndicator.hidden = false
        
        if self.filterSelected == "Todos" {
        
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
        else if self.filterSelected == "Recomendados" {
            RestApiHelper.sharedInstance().getPreferencePosts(
                { (postsReturn: NSArray) in
                    self.posts = postsReturn
                    
                    // Recarga el slides
                    self.collectionView.reloadData()
                    // Oculta el indicador
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.hidden = true
            })
        }

        
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if (collectionView == self.collectionView) {
            // POSTS
            return self.posts.count
        } else {
            // Filtros
            return self.filters.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        if (collectionView == self.collectionView) {
            // POSTS
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
                cell.imagen.setImageWithURLRequest(NSURLRequest(URL: NSURL(string: images.objectAtIndex(0) as String)), placeholderImage: self.imageEmpty, success: { (request, response, image) -> Void in
                    // Setea las imagenes
                    cell.imagen.image = image
                    if (indexPath.row == 0 || (self.collectionView.visibleCells() as NSArray).containsObject(indexPath.row)) {
                        self.setImageToBackground(image)
                    }
                    }, failure:nil)
            }
            
            // Sombreado
            cell.fondo.layer.shadowColor = UIColor.blackColor().CGColor;
            cell.fondo.layer.shadowOffset = CGSizeMake(2.5, 2.5);
            cell.fondo.layer.shadowOpacity = 0.6;
            cell.fondo.layer.shadowRadius = 1.0;
            cell.fondo.clipsToBounds = false;
            //
            
            return cell
        } else {
            // Filtros
            // Categories
            var cell : CategoryCell = collectionView.dequeueReusableCellWithReuseIdentifier("FilterCell", forIndexPath: indexPath) as CategoryCell
            
            // Configuro la celda
            cell.name.text = self.filters[indexPath.row] as String

            return cell

        }
    }
    
    // MARK: - UICollectionDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == self.filtersCollectionView {
            // Filters
            self.filterSelected = self.filters[indexPath.row]
            self.getData()
        }
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
