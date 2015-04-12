//
//  TodayViewController.swift
//  CiudadInvisibleWidget
//
//  Created by Mathias on 7/12/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreLocation

class TodayViewController: UIViewController {
  
  @IBOutlet weak var takeTheMomentButton: UIButton!
  
  var locationManager: CLLocationManager! = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // User location
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.delegate = self
    self.locationManager.startUpdatingLocation()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // Mark: - Actions
  @IBAction func takeTheMoment(sender: AnyObject) {
    println("Take the moment pressed")
    
    self.extensionContext?.openURL(NSURL(string: "CiudadInvisible://")!, completionHandler: nil)
  }
  
}

// MARK: - NCWidgetProviding
extension TodayViewController: NCWidgetProviding {
  func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResult.Failed
    // If there's no update required, use NCUpdateResult.NoData
    // If there's an update, use NCUpdateResult.NewData
    
    completionHandler(NCUpdateResult.NewData)
  }
  
  func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
    return UIEdgeInsetsMake(10.0, 4.0, 10.0, 4.0)
  }
}

// MARK: - CLLocationManagerDelegate
extension TodayViewController: CLLocationManagerDelegate {
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    var location: CLLocation = locations.last as CLLocation
    println(location.coordinate)
    
    self.locationManager.stopUpdatingLocation()
  }
  
  func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
    println(error)
  }
}