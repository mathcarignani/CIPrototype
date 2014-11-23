//
//  PostARViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 04/10/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit

class PostARViewController: UIViewController, PRARManagerDelegate {

    var prARManager: PRARManager! = nil
    var posts : NSArray! = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialice the manager
        self.prARManager = PRARManager.sharedManagerWithRadarAndSize(self.view.frame.size, andDelegate: self) as PRARManager

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    override func viewDidAppear(animated: Bool) {
        self.loadPoints()
    }
    
    // MARK: - AR Data
    func loadPoints() {
        var locationCoordinates: CLLocationCoordinate2D = CLLocationCoordinate2DMake(-34.9060165250200, -56.1930646562800)
        var points: NSMutableArray = NSMutableArray(capacity: self.posts.count)
        var idAux: Int = 0
        
        // Carga los puntos en el mapa
        for post : AnyObject in self.posts {
            
            if (post as Post).title != nil {
                var coordinate = (post as Post).coordinate()
                var point: NSDictionary = ["id": idAux,
                                            "title": (post as Post).title,
                                            "lon": coordinate.longitude,
                                            "lat": coordinate.latitude]
                points.addObject(point)
            }
        }
        
        self.prARManager.startARWithData(points, forLocation: locationCoordinates)
    }

    // MARK: - PRARManagerDelegate
    func prarDidSetupAR(arView: UIView!, withCameraLayer cameraLayer: AVCaptureVideoPreviewLayer!, andRadarView radar: UIView!) {
        self.view.layer.addSublayer(cameraLayer)
        self.view.addSubview(arView)
        
        self.view.bringSubviewToFront(self.view.viewWithTag(Int(AR_VIEW_TAG))!)
        self.view.addSubview(radar)
        
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
