//
//  PostsMapViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 29/08/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit
import MapKit

class PostsMapViewController: UIViewController, MKMapViewDelegate {

    var posts : NSArray! = NSArray()
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Si no hay posts los voy a buscar a la API
        if !self.posts {
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
    
    // MARK: Actions
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: UI
    func configOutlets() {
        // Mapa
        self.mapView.showsUserLocation = true
        self.mapView.mapType = MKMapType.Standard
        self.mapView.delegate = self
        
        // Carga los puntos en el mapa
        for post : AnyObject in self.posts {
            
            var annotation: PostAnnotation = PostAnnotation()
            annotation.coordinate = (post as Post).coordinate()
            annotation.title = (post as Post).title
            annotation.post = (post as Post)
            self.mapView.addAnnotation(annotation)
        }
    }
    
    // MARK: MapViewDelegate
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        // Cuando se actualiza la posicion del usuario centra el mapa en ese punto
        MapHelper.centerMap(self.mapView, coordinate: self.mapView.userLocation.coordinate, distance: 800)
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
}
