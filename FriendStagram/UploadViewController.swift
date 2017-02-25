//
//  UploadViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-02-24.
//  Copyright © 2017 RBSoftware. All rights reserved.
//

import Foundation
import UIKit
import Cloudinary

class UploadViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var uploadButton : UIButton!
    
    override func viewDidLoad() {
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UpdatingProfilePicture)))
        
        uploadButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        uploadButton.backgroundColor = UIColor(red: 0.20, green: 0.60, blue: 0.86, alpha: 1.00)
        uploadButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SubmitPost)))
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    @IBAction func SubmitPost(){
        let image = imageView.image
        let cloudinary = CLDCloudinary(configuration: AppDelegate.globalAPI.config)
        let signature = CLDSignature(signature: "sgjfdoigfjdgfdogidf9g87df98gfdb8f7d6gfdg7gfd8", timestamp: 1346925631)
        let params = CLDUploadRequestParams()
        params.setSignature(signature)
        cloudinary.createUploader().upload(data: UIImageJPEGRepresentation(image!, 1.0)!, uploadPreset: "sjfbnkp5", params: params, progress: {
            (progress) in
                print(progress)
        }, completionHandler: {
            (res, error) in
                if(error == nil){
                        print("Public id:", res!.publicId!)
                        print("Signature: ", res!.signature!)
                        print("Image URL: ", res!.url!)
                }
        })
        
    }
    
    @IBAction func UpdatingProfilePicture(){
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "How would you like to upload?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
