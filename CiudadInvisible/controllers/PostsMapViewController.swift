//
//  PostsMapViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 29/08/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PostsMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
  
  @IBOutlet var mapView: MKMapView!
  
  var posts : NSArray! = nil
  var centerMap : Int! = 1
  var locationManager: CLLocationManager! = CLLocationManager()
  private let transitionManager = TransitionManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.centerMap = 1
    
    // Si no hay posts los voy a buscar a la API
    if (self.posts == nil) {
      // Obtengo los posts
      RestApiHelper.sharedInstance().getPosts(
        { (postsReturn: NSArray) in
          self.posts = postsReturn
          self.configOutlets()
      })
    }
    
    self.configOutlets()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidDisappear(animated: Bool) {
    self.locationManager.stopUpdatingLocation()
  }
  
  // MARK: UI
  func configOutlets() {
    // Mapa
    self.mapView.showsUserLocation = true
    self.mapView.mapType = MKMapType.Standard
    self.mapView.delegate = self
    
    // Carga los puntos en el mapa
    // Si hay posts
    if (self.posts != nil) {
      for post : AnyObject in self.posts {
        var annotation = JPSThumbnail()
        annotation.title = ((post as Post).title != nil) ? (post as Post).title : "Incógnito"
        annotation.imageUrl = (post as Post).imagesSmall().count > 0 ? ((post as Post).imagesSmall().objectAtIndex(0) as String) : ""
        annotation.coordinate = (post as Post).coordinate()
        annotation.disclosureBlock = {
          // Obtiene el mapa, setea los posts para que no los obtenga denuevo y lo invoca
          var detailVC : PostsDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PostsDetailViewController") as PostsDetailViewController
          detailVC.post = post as Post
          detailVC.transitioningDelegate = self.transitionManager
          self.presentViewController(detailVC, animated: true, completion: { () -> Void in
            
          })
        }
        self.mapView.addAnnotation(JPSThumbnailAnnotation(thumbnail: annotation))
      }
    }
    
    // User location
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.delegate = self
    self.locationManager.startUpdatingLocation()
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

  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "GoToAR" {
      var vc: PostARViewController = segue.destinationViewController as PostARViewController
      vc.posts = self.posts
    }
  }
  
  // MARK: - MapViewDelegate
  func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
    (view as JPSThumbnailAnnotationView).didSelectAnnotationViewInMap(mapView)
  }
  
  func mapView(mapView: MKMapView!, didDeselectAnnotationView view: MKAnnotationView!) {
    (view as JPSThumbnailAnnotationView).didDeselectAnnotationViewInMap(mapView)
  }
  
  func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
    if (annotation.conformsToProtocol(JPSThumbnailAnnotationProtocol)) {
      return (annotation as JPSThumbnailAnnotation).annotationViewInMap(mapView)
    }
    return nil
  }
}
