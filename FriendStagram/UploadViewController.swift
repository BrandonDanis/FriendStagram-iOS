//
//  UploadViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-02-24.
//  Copyright © 2017 RBSoftware. All rights reserved.
//

import Foundation
import UIKit

class UploadViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var uploadButton : UIButton!
    
    override func viewDidLoad() {
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UpdatingProfilePicture)))
        
        uploadButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        uploadButton.backgroundColor = UIColor(red: 0.20, green: 0.60, blue: 0.86, alpha: 1.00)
        
    }
    
    override func didReceiveMemoryWarning() {
        
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
