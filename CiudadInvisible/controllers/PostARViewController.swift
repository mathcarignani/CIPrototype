//
//  PostARViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 04/10/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit
import CoreLocation

class PostARViewController: UIViewController, PRARManagerDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var goBack: UIButton!
    
    var locationManager: CLLocationManager! = CLLocationManager()
    var prARManager: PRARManager! = nil
    var posts : NSArray! = NSArray()
    var locationCoordinate: CLLocationCoordinate2D! = CLLocationCoordinate2DMake(-34.9060165250200, -56.1930646562800)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // User location
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        // Initialice the manager
        self.prARManager = PRARManager.sharedManagerWithRadarAndSize(self.view.frame.size, andDelegate: self) as PRARManager
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    override func viewDidAppear(animated: Bool) {
//        self.loadPoints()
    }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    self.locationManager.stopUpdatingLocation()
    self.prARManager.stopAR()
  }
    
    @IBAction func backToMap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var location: CLLocation = locations.last as CLLocation
        self.locationCoordinate = location.coordinate
        self.locationManager.stopUpdatingLocation()
      self.loadPoints()
    }
    
    // MARK: - AR Data
    func loadPoints() {
      
      // Get posts
      RestApiHelper.sharedInstance().getNearbyPosts(self.locationCoordinate, completion: { (posts) -> () in
        
        self.posts = posts
        var points: NSMutableArray = NSMutableArray(capacity: self.posts.count)
        var idAux: Int = 0
        
        // Carga los puntos en el mapa
        for post : AnyObject in self.posts {
          if (post as Post).title != nil {
            var image = (post as Post).imagesMedium().count > 0 ? (post as Post).imagesMedium().objectAtIndex(0) as String : ""
            var coordinate = (post as Post).coordinate()
            var point: NSDictionary = ["id": (post as Post).id,
              "title": (post as Post).title,
              "lon": coordinate.longitude,
              "lat": coordinate.latitude,
              "image": image]
            points.addObject(point)
          }
        }
        
        self.prARManager.startARWithData(points, forLocation: self.locationCoordinate)
        
      })
    }

    // MARK: - PRARManagerDelegate
    func prarDidSetupAR(arView: UIView!, withCameraLayer cameraLayer: AVCaptureVideoPreviewLayer!, andRadarView radar: UIView!) {
        self.view.layer.addSublayer(cameraLayer)
        self.view.addSubview(arView)
        
        self.view.bringSubviewToFront(self.view.viewWithTag(Int(AR_VIEW_TAG))!)
        self.view.addSubview(radar)
        
        self.view.bringSubviewToFront(self.goBack)
    }
    
    func prarUpdateFrame(arViewFrame: CGRect) {
        (self.view.viewWithTag(Int(AR_VIEW_TAG))! as UIView).frame = arViewFrame
    }
    
    func prarDidSetupAR(arView: UIView!, withCameraLayer cameraLayer: AVCaptureVideoPreviewLayer!) {
        self.view.layer.addSublayer(cameraLayer)
        self.view.addSubview(arView)
        
        self.view.bringSubviewToFront(self.view.viewWithTag(Int(AR_VIEW_TAG))!)
    }
}
