//
//  NewPostViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 20/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NewPostViewController: UITableViewController, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, MultiImagesViewControllerDelegate, UITextViewDelegate, CLLocationManagerDelegate {
  
  @IBOutlet var titleText: UITextField!
  @IBOutlet var descriptionText: UITextView!
  @IBOutlet weak var categoriesCollectionView: UICollectionView!
  @IBOutlet var imagesCollectionView: UICollectionView!
  @IBOutlet var mapView: MKMapView!
  @IBOutlet weak var avatar: UIImageView!
  @IBOutlet weak var author: UILabel!
  
  var locationManager: CLLocationManager! = CLLocationManager()
  var centerMap : Int! = 1
  var mainImageView: UIImageView! = nil
  var imageMain : UIImage! = nil
  var images : NSMutableArray = []
  var categories: NSArray! = nil
  var category : NSString! = nil
  var categoriesSelected: NSMutableArray! = nil
  let placeholderText = "Ingrese una breve descripción de su lugar invisible, por ejemplo la historia que usted considera que tiene o el significado que tiene para usted..."
  
  // MARK: - LifeCycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.categoriesSelected = NSMutableArray()
    
    self.configUI()
  }
  
  override func viewWillAppear(animated: Bool) {
    
  }
  
  override func viewDidDisappear(animated: Bool) {
    self.locationManager.stopUpdatingLocation()
  }
  
  // MARK: - UI
  func configUI() {
    
    self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "bgBlur1.png")!)
    self.tableView.separatorColor = UIColor.clearColor()
    
    // Configuracion fondo de la tabla para imagen principal del post
    self.mainImageView = UIImageView()
    self.mainImageView.frame = self.view.frame
    self.mainImageView.backgroundColor = UIColor(red: 170/255.0, green: 170/255.0, blue: 170/255.0, alpha: 0.5)
    self.mainImageView.contentMode = UIViewContentMode.ScaleAspectFill
    self.tableView.backgroundView = self.mainImageView
    
    // Description
    self.descriptionText.delegate = self
    
    // Obtiene las categorias
    RestApiHelper.sharedInstance().getCategories { (categories) -> () in
      self.categories = categories
      self.categoriesCollectionView.reloadData()
    }
    
    // User location
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.delegate = self
    self.locationManager.startUpdatingLocation()
    
    // User
    let user: User = UserSesionHelper.sharedInstance().getUserLogued()
    self.author.text = "by \(user.name())"
    self.avatar.setImageWithURL(NSURL(string: user.url_avatar))
    self.avatar.layer.cornerRadius = self.avatar.frame.width / 2
    self.avatar.layer.masksToBounds = true
  }
  
  // MARK: - Actions
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
    ProgressHUD.show("Guardando post...")
    
    var post: Post = Post()
    post.title = self.titleText.text
    post.author = UserSesionHelper.sharedInstance().getUserLogued().name()
    post.descriptionText = self.descriptionText.text == placeholderText ? "" : self.descriptionText.text
    post.date = NSDate()
    //post.category = self.categorySelector.titleForSegmentAtIndex(self.categorySelector.selectedSegmentIndex)
    // Auxiliar para concatenar las imagenes
    var arrayAuxiliar = NSMutableArray(object: self.imageMain)
    arrayAuxiliar.addObjectsFromArray(self.images)
    post.images = arrayAuxiliar
    // Guarda la coordenada del centro del mapa
    post.location = "{\(self.mapView.centerCoordinate.latitude),\(self.mapView.centerCoordinate.longitude)}"
    post.latitude = self.mapView.centerCoordinate.latitude
    post.longitude = self.mapView.centerCoordinate.longitude
    post.draft = false
    
    RestApiHelper.sharedInstance().createPost(post, completion: { (success) -> () in
      
      ProgressHUD.dismiss()
      if success {
        self.dismissViewControllerAnimated(true, completion: nil)
      } else {
        ProgressHUD.showError("Error al crear el post")
      }
    })
    
  }
  
  @IBAction func createDraft(sender: AnyObject) {
    ProgressHUD.show("Enviando...")
    
    var post: Post = Post()
    post.title = self.titleText.text
    post.author = UserSesionHelper.sharedInstance().getUserLogued().name()
    post.descriptionText = self.descriptionText.text == placeholderText ? "" : self.descriptionText.text
    post.date = NSDate()
    //post.category = self.categorySelector.titleForSegmentAtIndex(self.categorySelector.selectedSegmentIndex)
    // Auxiliar para concatenar las imagenes
    var arrayAuxiliar = NSMutableArray(object: self.imageMain)
    arrayAuxiliar.addObjectsFromArray(self.images)
    post.images = arrayAuxiliar
    // Guarda la coordenada del centro del mapa
    post.location = "{\(self.mapView.centerCoordinate.latitude),\(self.mapView.centerCoordinate.longitude)}"
    post.latitude = self.mapView.centerCoordinate.latitude
    post.longitude = self.mapView.centerCoordinate.longitude
    
    RestApiHelper.sharedInstance().createPost(post, completion: { (success) -> () in
      
      ProgressHUD.dismiss()
      if success {
        self.dismissViewControllerAnimated(true, completion: nil)
      } else {
        ProgressHUD.showError("Error al crear el post")
      }
    })
    
  }
  
  @IBAction func cancel(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  // MARK: - UIImagePickerControllerDelegate
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
  
  // MARK: - UITableViewDelegate
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
    if indexPath.row == 0 {
      return self.view.frame.height
    } else if indexPath.row == 3 {
      return 68
    } else if indexPath.row == 5 {
      return 71
    } else {
      return 200
    }
  }
  
  // MARK: - Hide Keyboard
  @IBAction func textFieldReturn(sender: AnyObject!) {
    sender.resignFirstResponder()
  }
  
  // MARK: - Segue
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    
    if segue.identifier == "ChangeImages" {
      
      var destVC = segue.destinationViewController as MultiImagesViewController
      destVC.delegate = self
      destVC.imagenes = self.images
      
    }
    
  }
  
  // MARK: - CLLocationManagerDelegate
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    var location: CLLocation = locations.last as CLLocation
    // Cuando se actualiza la posicion del usuario centra el mapa en ese punto
    if (self.centerMap == 1) {
      MapHelper.centerMap(self.mapView, coordinate: location.coordinate, distance: 800)
      
      self.centerMap = 0
    }
  }
  
  // MARK: - MultiImagesViewControllerDelegate
  func multiImagesDoneWithImages(images: NSMutableArray) {
    self.images = images
    // Refresca los datos de la collection
    self.imagesCollectionView.reloadData()
  }
  
  // MARK: - UICollectionViewDataSource
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
  {
    if collectionView == self.imagesCollectionView {
      // Images
      return self.images.count
    } else {
      // Categories
      return self.categories.count
    }
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
  {
    if collectionView == self.imagesCollectionView {
      // Images
      var cell : PostImagesCell = collectionView.dequeueReusableCellWithReuseIdentifier("PostImageCell", forIndexPath: indexPath) as PostImagesCell
      
      // Configuro la celda
      cell.image.image = self.images.objectAtIndex(indexPath.row) as? UIImage
      
      return cell
    } else {
      // Categories
      var cell : CategoryCell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryCell", forIndexPath: indexPath) as CategoryCell
      
      // Configuro la celda
      cell.name.text = self.categories.objectAtIndex(indexPath.row) as? NSString
      // Si está seleccionada la categoria la pinta
      if (self.categoriesSelected.containsObject(cell.name.text!)) {
        cell.backgroundView?.backgroundColor = UIColor(red: 166/255.0, green: 251/255.0, blue: 255/255.0, alpha: 0.7)
        cell.name.textColor = UIColor.whiteColor()
      } else {
        cell.backgroundView?.backgroundColor = UIColor.clearColor()
        cell.backgroundView?.layer.borderColor = UIColor(red: 166/255.0, green: 251/255.0, blue: 255/255.0, alpha: 0.7).CGColor
        cell.backgroundView?.layer.borderWidth = 1.0
        cell.name.textColor = UIColor.whiteColor()
      }
      
      return cell
    }
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    if collectionView == self.imagesCollectionView {
      // Images
    } else {
      // Categories
      // Agrega el objeto seleccionado si no existe sino lo borrar
      if self.categoriesSelected.containsObject(self.categories.objectAtIndex(indexPath.row)) {
        self.categoriesSelected.removeObject(self.categories.objectAtIndex(indexPath.row))
      } else {
        self.categoriesSelected.addObject(self.categories.objectAtIndex(indexPath.row))
      }
      self.categoriesCollectionView.reloadData()
    }
    
  }
  
  // MARK: - UITextViewDelegate
  func textViewDidBeginEditing(textView: UITextView) {
    if textView.text == placeholderText {
      textView.text = ""
    }
    textView.becomeFirstResponder()
  }
  
  func textViewDidEndEditing(textView: UITextView) {
    if textView.text == "" {
      textView.text = placeholderText
    }
    textView.resignFirstResponder()
  }
}
