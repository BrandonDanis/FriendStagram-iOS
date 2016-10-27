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
    
    var frontFacing : Bool = false
    
    var myImage : UIImage!
    
    let cameraManager = CameraManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        cameraManager.addPreviewLayerToView(self.cameraView)
        cameraManager.cameraDevice = .back
        cameraManager.cameraOutputMode = .videoOnly
        cameraManager.cameraOutputQuality = .high
        
        cancelButton.isHidden = true
        cancelButton.isUserInteractionEnabled = false
        
        cameraManager.showAccessPermissionPopupAutomatically = true
        
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
