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
    
    var frontFacing : Bool = false
    
    let cameraManager = CameraManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        cameraManager.addPreviewLayerToView(self.cameraView)
        cameraManager.cameraDevice = .front
        cameraManager.cameraOutputMode = .videoOnly
        
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
    
}
