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

    @IBOutlet var cameraPreviewView : CameraPreviewView

    var session : AVCaptureSession = AVCaptureSession()
    /*var videoDeviceInput : AVCaptureDeviceInput = AVCaptureDeviceInput()
    var movieFileOutput : AVCaptureMovieFileOutput = AVCaptureMovieFileOutput()
    var stillImageOutput : AVCaptureStillImageOutput = AVCaptureStillImageOutput()*/
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.configurarCamara()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //
        //self.arrancarCamara()
    }
  
    func configurarCamara() {
        
        session.sessionPreset = AVCaptureSessionPreset352x288
        
        session.beginConfiguration()
        session.commitConfiguration()
        
        var input : AVCaptureDeviceInput! = nil
        var err : NSError?
        var devices : [AVCaptureDevice] = AVCaptureDevice.devices() as [AVCaptureDevice]
        for device in devices {
            if device.hasMediaType(AVMediaTypeVideo) && device.supportsAVCaptureSessionPreset(AVCaptureSessionPreset352x288) {
                
                input = AVCaptureDeviceInput.deviceInputWithDevice(device as AVCaptureDevice, error: &err) as AVCaptureDeviceInput
                
                if session.canAddInput(input) {
                    session.addInput(input)
                    break
                }
            }
        }
        
        /*var settings = [kCVPixelBufferPixelFormatTypeKey:kCVPixelFormatType_32BGRA]
        
        var output = AVCaptureVideoDataOutput()
        output.videoSettings = settings
        output.alwaysDiscardsLateVideoFrames = true
        
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        */
        
        var captureLayer = AVCaptureVideoPreviewLayer(session: session)
        
        cameraPreviewView.setSession(session)
    }
    
    func arrancarCamara() {
        self.session.startRunning()
    }

}
