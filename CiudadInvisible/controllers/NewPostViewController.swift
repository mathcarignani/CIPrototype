//
//  NewPostViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 20/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit
import MapKit

class NewPostViewController: UITableViewController, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDataSource, MultiImagesViewControllerDelegate {

    
    @IBOutlet var titleText: UITextField!
    @IBOutlet var descriptionText: UITextView!
    @IBOutlet var categorySelector: UISegmentedControl!
    @IBOutlet var imagesCollectionView: UICollectionView!
    @IBOutlet var mapView: MKMapView!
    
    var mainImageView: UIImageView! = nil
    var imageMain : UIImage! = nil
    var images : NSMutableArray = []
    var category : NSString! = nil
    
    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // Configuracion fondo de la tabla para imagen principal del post
        self.mainImageView = UIImageView()
        self.mainImageView.frame = self.view.frame
        self.mainImageView.backgroundColor = UIColor(red: 170/255.0, green: 170/255.0, blue: 170/255.0, alpha: 0.5)
        self.tableView.backgroundView = self.mainImageView
        
        // Configuracion del mapa
        let coordinate = CLLocationCoordinate2D(latitude: -34.9087458, longitude: -56.1614022137041)
        MapHelper.centerMap(self.mapView, coordinate: coordinate, distance: 1000)
        // Agrega el marcador en el centro del mapa
       // var markerImageView = UIImageView(image: UIImage(named: "marker.png"))
       // markerImageView.center = map
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    @IBAction func changeMainImage(sender: AnyObject) {
        var picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        // Si permite usar la camara la usa, sino la libreria
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            picker.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        self.presentViewController(picker, animated: true, completion: {})
    }
    
    @IBAction func createPost(sender: AnyObject) {
        
        var post: Post = Post()
        post.title = self.titleText.text
        post.author = UserSesionHelper.sharedInstance().getUserLogued().name()
        post.descriptionText = self.descriptionText.text
        post.date = NSDate()
        post.category = self.categorySelector.titleForSegmentAtIndex(self.categorySelector.selectedSegmentIndex)
        // Auxiliar para concatenar las imagenes
        var arrayAuxiliar = NSMutableArray(object: self.imageMain)
        arrayAuxiliar.addObjectsFromArray(self.images)
        post.images = arrayAuxiliar
        // Guarda la coordenada del centro del mapa
        post.location = "{\(self.mapView.centerCoordinate.latitude),\(self.mapView.centerCoordinate.longitude)}"
        
        RestApiHelper.sharedInstance().createPost(post)
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        
        // Carga la imagen en el visualizador y la guarda en la variable
        self.mainImageView.image = image
        self.imageMain = image
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        // Cierra el seleccionador directamente
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: UITableViewDelegate
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        
        if indexPath.row == 0 {
            return self.view.frame.height
        } else if indexPath.row == 3 {
            return 80
        } else if indexPath.row == 5 {
            return 71
        } else {
            return 200
        }
    }
    
    // MARK: Hide Keyboard
    @IBAction func textFieldReturn(sender: AnyObject!) {
        sender.resignFirstResponder()
    }
    
    // MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        if segue.identifier == "ChangeImages" {
            
            var destVC = segue.destinationViewController as MultiImagesViewController
            destVC.delegate = self
            destVC.imagenes = self.images
            
        }
        
    }
    
    // MARK: MultiImagesViewControllerDelegate
    func multiImagesDoneWithImages(images: NSMutableArray) {
        self.images = images
        // Refresca los datos de la collection
        self.imagesCollectionView.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
    {
        return self.images.count
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!
    {
        var cell : PostImagesCell = collectionView.dequeueReusableCellWithReuseIdentifier("PostImageCell", forIndexPath: indexPath) as PostImagesCell
        
        // Configuro la celda
        cell.image.image = self.images.objectAtIndex(indexPath.row) as UIImage

        return cell
    }
}
