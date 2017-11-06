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

class UploadViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var uploadButton : UIButton!
    @IBOutlet var progressBar : UIProgressView!
    @IBOutlet var errorLabel : UILabel!
    @IBOutlet var descriptionTextView : UITextView!
    
    override func viewDidLoad() {
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UpdatingPicture)))
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Billabong", size: 28)!,  NSForegroundColorAttributeName: UIColor.black]
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        uploadButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        uploadButton.backgroundColor = UIColor(red: 0.20, green: 0.60, blue: 0.86, alpha: 1.00)
        uploadButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SubmitPost)))
        
        progressBar.tintColor = UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.00)
        progressBar.setProgress(0.0, animated: false)
        
        errorLabel.alpha = 0
        
        descriptionTextView.delegate = self
        descriptionTextView.layer.borderColor = Style.upload_description_textview_border_color.cgColor
        descriptionTextView.layer.borderWidth = 2.0
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    //removing status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func SubmitPost(){
        let image = imageView.image
        let description = descriptionTextView.text!
        
        if(image == #imageLiteral(resourceName: "placeholder")){
            return
        }
        
        let cloudinary = CLDCloudinary(configuration: AppDelegate.globalAPI.config)
        let signature = CLDSignature(signature: "sgjfdoigfjdgfdogidf9g87df98gfdb8f7d6gfdg7gfd8", timestamp: 1346925631)
        let params = CLDUploadRequestParams()
        params.setSignature(signature)
        uploadButton.isUserInteractionEnabled = false
        uploadButton.setTitle("Uploading to image server", for: .normal)
        
        cloudinary.createUploader().upload(data: UIImageJPEGRepresentation(image!, 1.0)!, uploadPreset: "sjfbnkp5", params: params, progress: {
            (progress) in
                self.progressBar.setProgress(Float(progress.fractionCompleted), animated: true)
        }, completionHandler: {
            (res, error) in
                if(error == nil){
                    
                    self.uploadButton.setTitle("Uploading to FriendStagram", for: .normal)
                    
                    AppDelegate.globalAPI.SubmitPost(_imageUrl: res!.url!, _desc: description, _tags: "", completion: { (res) in
                        
                        if(res["status"] == "200"){
                            self.uploadButton.setTitle("Success!", for: .normal)
                            
                            //re-enabling upload button
                            self.uploadButton.isUserInteractionEnabled = true
                        }else{
                            self.uploadButton.setTitle("Failed to upload", for: .normal)
                            self.DisplayError("Failed to Upload. Error code: " + res["status"]!)
                            self.uploadButton.backgroundColor = UIColor(red:0.75, green:0.23, blue:0.19, alpha:1.00)
                        }
                        
                    })
                }else{
                    self.DisplayError(error?.userInfo["message"] as! String)
            }
        })
        
    }
    
    @IBAction func UpdatingPicture(){
        self.uploadButton.setTitle("Upload", for: .normal)
        
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
    
    private func ResetDisplay(){
        self.uploadButton.isUserInteractionEnabled = true
        self.imageView.image = #imageLiteral(resourceName: "placeholder")
        self.uploadButton.setTitle("Upload", for: .normal)
    }
    
    private func DisplayError(_ msg: String){
        self.errorLabel.text = msg
        UIView.animate(withDuration: 1.0, animations: {
            self.errorLabel.alpha = 1.0
            
            UIView.animate(withDuration: 1.0, delay: 8.0, options: .curveEaseIn, animations: {
                self.errorLabel.alpha = 0.0
            }, completion: nil)
        })
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print(text)
        if(text == "\n"){
            descriptionTextView.resignFirstResponder()
            return false
        }
        
        return true
        
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
