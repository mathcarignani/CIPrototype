//
//  CameraPreviewView.swift
//  CiudadInvisible
//
//  Created by Mathias on 06/07/14.
//  Copyright (c) 2014 CiudadInvisible. All rights reserved.
//

import UIKit
import AVFoundation

class CameraPreviewView: UIView {

    override class func layerClass() -> AnyClass! {
        return AVCaptureVideoPreviewLayer.self
    }
    
    func session() -> AVCaptureSession {
        let aux : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(layer: self.layer)
        return aux.session
    }
    
    func setSession(session : AVCaptureSession) {
        var aux : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(layer: self.layer)
        aux.session = session
    }
    
}
