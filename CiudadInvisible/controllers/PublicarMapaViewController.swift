//
//  PublicarMapaViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 12/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit
import MapKit

class PublicarMapaViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView : MKMapView
    
    var coordinate : CLLocationCoordinate2D! = nil
    let distanceToCoordinate : CLLocationDistance = 1000
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loadMap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func volver(sender : AnyObject) {
        self.dismissModalViewControllerAnimated(true)
    }
    
    // MARK: Auxiliares
    func loadMap() {
        self.mapView.showsUserLocation = true
        self.mapView.mapType = MKMapType.Standard
        
        // Agrega el gesto al mapa
        var longTapInMap = UILongPressGestureRecognizer(target: self, action: Selector("longTapInMap:"))
        self.mapView.addGestureRecognizer(longTapInMap)

    }
    
    // MARK: Gestos
    func longTapInMap(recognizer : UILongPressGestureRecognizer) {
        
        // Cuando inicia el toque agrego el pin y configuro la region
        if (recognizer.state == UIGestureRecognizerState.Began) {
            // Obtener el punto en el mapa
            let point : CGPoint = recognizer.locationInView(self.mapView)
            // Guarda la coordenada
            self.coordinate = self.mapView.convertPoint(point, toCoordinateFromView: self.mapView)
            
            // Agrega el pin
            var annotation = MKPointAnnotation()
            annotation.coordinate = self.coordinate
            annotation.title = "Ubicación del post"
            self.mapView.addAnnotation(annotation)
            
        }

    }
    
    // MARK: MapViewDelegate
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        // Cuando se actualiza la posicion del usuario centra el mapa en ese punto
        self.centerMap(userLocation.coordinate)
    }
    
    func centerMap(coordinate: CLLocationCoordinate2D) {
        // Crea la region y centra el mapa
        let region = MKCoordinateRegionMakeWithDistance(coordinate, self.distanceToCoordinate, self.distanceToCoordinate)
        self.mapView.setRegion(region, animated: true)
    }
    
    /*
    #pragma mark -Mapa
    - (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
    {
    [self centerMap:userLocation.coordinate];
    }
    
    - (void)centerMap:(CLLocationCoordinate2D)coordinate
    {
    if (!_mapUpdated)
    {
    // Centro el mapa
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (coordinate, radioMap, radioMap);
    [_map setRegion:region animated:YES];
    
    _mapUpdated = YES;
    }
    }
    */

}
