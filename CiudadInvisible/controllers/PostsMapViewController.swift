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
                var annotation: PostAnnotation = PostAnnotation()
                annotation.coordinate = (post as Post).coordinate()
                annotation.title = ((post as Post).title != nil) ? (post as Post).title : "Title"
                annotation.post = (post as Post)
                self.mapView.addAnnotation(annotation)
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
    
    /*
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!){
       // Cuando se toca el pin se dispara este metodo
    }
    */
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        // Obtiene el mapa, setea los posts para que no los obtenga denuevo y lo invoca
        var detailVC : PostsDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PostsDetailViewController") as PostsDetailViewController
        detailVC.post = (view.annotation as PostAnnotation).post
        self.presentViewController(detailVC, animated: true) { () -> Void in
        }
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToAR" {
            var vc: PostARViewController = segue.destinationViewController as PostARViewController
            vc.posts = self.posts
        }
    }
}
