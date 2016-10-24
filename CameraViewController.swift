//
//  CameraViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2016-10-24.
//  Copyright © 2016 RBSoftware. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class CameraViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var cameraView : UIView!
    
    var captureSession : AVCaptureSession?
    var stillImageOutput : AVCapturePhotoOutput?
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        let input = try? AVCaptureDeviceInput(device: backCamera)
        
        captureSession?.addInput(input)
        
        stillImageOutput = AVCapturePhotoOutput()
        
        
        
        if(captureSession?.canAddOutput(stillImageOutput) != nil){
            captureSession?.addOutput(stillImageOutput)
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
            previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.portrait
            cameraView.layer.addSublayer(previewLayer!)
            captureSession?.startRunning()
            print("Success?")
        }
        
        
    }
    
}
