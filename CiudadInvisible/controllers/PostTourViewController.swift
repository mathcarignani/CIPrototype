//
//  PostTourViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 24/11/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PostTourViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
  
  @IBOutlet weak var mapView: MKMapView!
  
  var locationManager: CLLocationManager! = CLLocationManager()
  var centerMap : Int! = 1
  private let transitionManager = TransitionManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // User location
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.delegate = self
    self.locationManager.startUpdatingLocation()
    
    // Mapa
    self.mapView.delegate = self
    self.mapView.showsUserLocation = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    self.locationManager.stopUpdatingLocation()
  }
  
  // MARK: - CLLocationManagerDelegate
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    var location: CLLocation = locations.last as CLLocation
    // Cuando se actualiza la posicion del usuario centra el mapa en ese punto
    if (self.centerMap == 1) {
      MapHelper.centerMap(self.mapView, coordinate: location.coordinate, distance: 800)
      
      self.centerMap = 0
      
      // Obtine los datos del tour
      RestApiHelper.sharedInstance().getRandomTour(location.coordinate, completion: { (posts) -> () in
        
        var startPoint = location.coordinate
        var i = 0
        // Si hay posts
        if (posts.count != 0) {
          for post : AnyObject in posts {
            i = i + 1
            
            var annotation = JPSThumbnail()
            annotation.title = ((post as Post).title != nil) ? (post as Post).title : "Incógnito"
            annotation.imageUrl = (post as Post).images.count > 0 ? ((post as Post).imagesSmall().objectAtIndex(0) as String) : ""
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
            
            // Linea entre los puntos
            self.markLinePoints(startPoint, destination: (post as Post).coordinate())
            startPoint = (post as Post).coordinate()
          }
        }
      })
    }
  }
  
  func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
    NSLog("Error in PostTour: %@", error)
  }
  
  // MARK: - Aux
  func markLinePoints(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
    
    var fromItem: MKMapItem = MKMapItem(placemark: MKPlacemark(coordinate: source, addressDictionary: nil))
    var toItem: MKMapItem = MKMapItem(placemark: MKPlacemark(coordinate: destination, addressDictionary: nil))
    
    var request: MKDirectionsRequest = MKDirectionsRequest()
    request.setSource(fromItem)
    request.setDestination(toItem)
    request.transportType = MKDirectionsTransportType.Walking
    
    var directions: MKDirections = MKDirections(request: request)
    directions.calculateDirectionsWithCompletionHandler { (response, error) -> Void in
      if error != nil {
        println(error)
      } else {
        var route: MKRoute = response.routes[0] as MKRoute
        self.drawRoute(route.polyline)
      }
    }
  }
  
  func drawRoute(polyline: MKPolyline) {
    self.mapView.addOverlay(polyline)
  }
  
  // MARK: - MapViewDelegate
  func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
    var polylineRender: MKPolylineRenderer = MKPolylineRenderer(overlay: overlay)
    polylineRender.strokeColor = UIColor(red: 0, green: 146/255.0, blue: 105/255.0, alpha: 1)
    polylineRender.lineWidth = 2.0
    return polylineRender
  }
  
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
  
  // MARK: - Actions
  @IBAction func showMenu(sender: AnyObject) {
    let menu: XDKAirMenuController = XDKAirMenuController.sharedMenu()
    if menu.isMenuOpened {
      menu.closeMenuAnimated()
    } else {
      menu.openMenuAnimated()
    }
  }
}
