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
import Cloudinary

class CameraViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var cameraView : UIView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var imageView : UIImageView!
    
    var cameraManager = CameraManager()
    
    var frontFacing : Bool = false
    var displayingPicture : Bool = false
    
    let config = CLDConfiguration(cloudName: "dajzmd3d8", apiKey: "386623978827134")
    
    var myImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .scaleAspectFill
        
        cameraManager.addPreviewLayerToView(self.cameraView)
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
        
        if (displayingPicture){
            return
        }
        self.displayingPicture = true
        
        cameraManager.capturePictureWithCompletion({ (image, error) -> Void in
            self.imageView.image = image
            self.cameraView.isHidden = true
            self.displayingPicture = true
            
            
            let cloudinary = CLDCloudinary(configuration: self.config)
            let signature = CLDSignature(signature: "sgjfdoigfjdgfdogidf9g87df98gfdb8f7d6gfdg7gfd8", timestamp: 1346925631)
            let params = CLDUploadRequestParams()
            params.setSignature(signature)
            cloudinary.createUploader().upload(data: UIImageJPEGRepresentation(image!, 1.0)!, uploadPreset: "sjfbnkp5", params: params, progress: nil, completionHandler: {
                (res, error) in
                
                if(error == nil){
                    print("Public id:", res!.publicId!)
                    print("Signature: ", res!.signature!)
                    print("Image URL: ", res!.url!)
                }
                
            })
            
        })
    }
    
    @IBAction func cancelPicture(_ sender: AnyObject) {
        cameraManager.cameraOutputMode = .videoOnly
        cancelButton.isHidden = true
        cancelButton.isUserInteractionEnabled = false
    }
    
}
