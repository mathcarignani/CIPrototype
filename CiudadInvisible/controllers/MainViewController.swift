//
//  MainViewController.swift
//  CiudadInvisible
//
//  Created by Mathias on 06/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {

    @IBOutlet var cameraPreview : CameraPreviewView

    var session : AVCaptureSession = AVCaptureSession()
    /*var videoDeviceInput : AVCaptureDeviceInput = AVCaptureDeviceInput()
    var movieFileOutput : AVCaptureMovieFileOutput = AVCaptureMovieFileOutput()
    var stillImageOutput : AVCaptureStillImageOutput = AVCaptureStillImageOutput()*/
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.configurarCamara()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //
        self.arrancarCamara()
    }
  
    func configurarCamara() {
        
        session = AVCaptureSession()
        
        // Configuro la vista previa
        cameraPreview.setSession(session)
        
        // Obtengo el dispositivo
        let devices : NSArray = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        let captureDevice : AVCaptureDevice = devices.firstObject() as AVCaptureDevice
        
        let videoDevice : AVCaptureDeviceInput = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: nil) as AVCaptureDeviceInput
    
        if (session.canAddInput(videoDevice)) {
            
            session.addInput(videoDevice)
            //videoDeviceInput = videoDevice
            
        }
    }
    
    func arrancarCamara() {
        session.startRunning()
    }

}
