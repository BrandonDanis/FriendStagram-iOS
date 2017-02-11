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
import CameraManager

class CameraViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var cameraView : UIView!
    @IBOutlet var cancelButton: UIButton!
    
    var cameraManager = CameraManager()
    
    var frontFacing : Bool = false
    
    var myImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("CAMERA LOADED");
        
        var cameraState = cameraManager.addPreviewLayerToView(self.cameraView)
        cameraManager.cameraDevice = .back
        cameraManager.cameraOutputMode = .videoOnly
        cameraManager.cameraOutputQuality = .high
        
        cancelButton?.isHidden = true
        cancelButton?.isUserInteractionEnabled = false
        
        cameraManager.showAccessPermissionPopupAutomatically = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @IBAction func swapCamera(_ sender: AnyObject) {
        
        if(frontFacing){
            cameraManager.cameraDevice = .back
            frontFacing = false
        }else{
            cameraManager.cameraDevice = .front
            frontFacing = true
        }
        
    }
    
    @IBAction func takePicture(_ sender: AnyObject) {
        cameraManager.capturePictureWithCompletion({ (image, error) -> Void in
            self.myImage = image
        })
    }
    
    @IBAction func cancelPicture(_ sender: AnyObject) {
        cameraManager.cameraOutputMode = .videoOnly
        cancelButton.isHidden = true
        cancelButton.isUserInteractionEnabled = false
    }
    
}
